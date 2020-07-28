local M = {}

M.collect = function(self, opts)
  local cmd = {"go", "list", "-f", "{{.ImportPath}} {{.Dir}}", "std"}
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self)
      local items = {}
      for _, output in ipairs(job_self:get_stdout()) do
        local package, dir = unpack(vim.split(output, " ", true))
        table.insert(items, {value = package, path = dir})
      end
      self.append(items)
    end,
    on_stderr = self.jobs.print_stderr,
    cwd = opts.cwd,
  })
  return {}, job
end

M.kind_name = "directory"

return M
