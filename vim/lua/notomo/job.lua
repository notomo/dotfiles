local M = {}

local Job = {}
Job.__index = Job

local close = function(handle)
  if handle == nil or handle:is_closing() then
    return
  end
  handle:close()
end

function Job._shutdown(self, code, signal)
  if self.on_interval then
    self.timer:stop()
  end
  self:stop()
  if self.on_exit then
    self:on_exit(code, signal)
  end
end

function Job.is_running(self)
  return self.handle ~= nil and self.handle:is_active()
end

function Job.start(self)
  self.stdin = vim.loop.new_pipe(false)
  self.stdout = vim.loop.new_pipe(false)
  self.stderr = vim.loop.new_pipe(false)

  local opts = {
    args = self.args,
    stdio = {self.stdin, self.stdout, self.stderr},
    cwd = self.cwd,
    env = self.env,
    detach = self.detach,
  }

  self.handle, self.pid = vim.loop.spawn(self.command, opts, vim.schedule_wrap(function(code, signal)
    self:_shutdown(code, signal)
  end))

  self.stdout:read_start(vim.schedule_wrap(function(err, data)
    if self.stdout_buffered and data ~= nil then
      self.stdout_output = self.stdout_output .. data
      self.all_output = self.all_output .. data
    end
    if self.on_stdout then
      self:on_stdout(err, data)
    end
  end))

  self.stderr:read_start(vim.schedule_wrap(function(err, data)
    if self.stderr_buffered and data ~= nil then
      self.stderr_output = self.stderr_output .. data
      self.all_output = self.all_output .. data
    end
    if self.on_stderr then
      self:on_stderr(err, data)
    end
  end))

  if self.on_interval then
    self.timer = vim.loop.new_timer()
    self.timer:start(self.interval_ms, 0, vim.schedule_wrap(function()
      self:on_interval()
      if self:is_running() then
        self.timer:again()
      end
    end))
  end
end

function Job.stop(self)
  self.stdout:read_stop()
  self.stderr:read_stop()

  if self.on_interval then
    self.timer:stop()
  end

  close(self.stdin)
  close(self.stderr)
  close(self.stdout)
  close(self.handle)
end

function Job.parse_output(data)
  return vim.split(data, "\n", true)
end

function Job.get_stdout(self)
  local output = self.parse_output(self.stdout_output)
  if output[#output] == "" then
    table.remove(output, #output)
  end
  return output
end

function Job.get_stderr(self)
  local output = self.parse_output(self.stderr_output)
  if output[#output] == "" then
    table.remove(output, #output)
  end
  return output
end

function Job.get_output(self)
  local output = self.parse_output(self.all_output)
  if output[#output] == "" then
    table.remove(output, #output)
  end
  return output
end

function Job.wait(self, ms)
  return vim.wait(ms, function()
    return not self:is_running()
  end, 10)
end

M.new = function(cmd_and_args, opts)
  local job = {}

  local command = table.remove(cmd_and_args, 1)
  local args = cmd_and_args
  job.command = command
  job.args = args
  job.cwd = opts.cwd
  job.env = opts.env
  job.detach = opts.detach

  job.on_stdout = opts.on_stdout
  job.on_stderr = opts.on_stderr
  job.on_exit = opts.on_exit

  job.stdout_output = ""
  job.stdout_buffered = true
  if opts.stdout_buffered ~= nil then
    job.stdout_buffered = opts.stdout_buffered
  end

  job.stderr_output = ""
  job.stderr_buffered = true
  if opts.stderr_buffered ~= nil then
    job.stderr_buffered = opts.stderr_buffered
  end

  job.all_output = ""

  job.on_interval = opts.on_interval
  job.interval_ms = opts.interval_ms or 1000

  return setmetatable(job, Job)
end

M.print_stderr = function(_, _, data)
  if data == nil or data == "" then
    return
  end
  vim.api.nvim_err_write(data .. "\n")
end

M.print_stdout = function(self)
  if self.stdout_output == "" then
    return
  end
  local output = table.concat(self:get_stdout(), "\n")
  vim.api.nvim_out_write(output .. "\n")
end

M.print_output = function(self)
  if self.all_output == "" then
    return
  end
  -- HACK: nvim_out_write does not display message
  vim.api.nvim_err_write("\n")
  local output = table.concat(self:get_output(), "\n")
  vim.api.nvim_out_write(output .. "\n")
end

return M
