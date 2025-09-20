local M = {}

function M.run(cmd, raw_opts)
  raw_opts = raw_opts or {}

  local cmd_name = table.concat(cmd, " ")
  local prefix = ("[%s]: "):format(cmd_name)

  local notify = raw_opts.notify or vim.notify
  local cwd = raw_opts.cwd or "."
  notify(prefix .. "starting")
  return vim.system(cmd, {
    cwd = cwd,
    stdout = function(_, data)
      if not data then
        return
      end
      local messages = vim.split(vim.trim(data), "\n", { plain = true })
      vim.schedule(function()
        for _, message in ipairs(messages) do
          notify(prefix .. message)
        end
      end)
    end,
    stderr = raw_opts.stderr or function(_, data)
      if not data then
        return
      end
      local messages = vim.split(vim.trim(data), "\n", { plain = true })
      vim.schedule(function()
        for _, message in ipairs(messages) do
          notify(prefix .. message, vim.log.levels.WARN)
        end
      end)
    end,
  }, function(o)
    vim.schedule(function()
      notify(prefix .. ("exit: %d"):format(o.code))
    end)
  end)
end

function M.terminal(cmd, raw_opts)
  local opts = vim.tbl_extend("force", { term = true }, raw_opts or {})
  local bufnr = vim.api.nvim_create_buf(false, true)
  local window_id = vim.api.nvim_open_win(bufnr, false, {
    split = "right",
  })
  vim.api.nvim_win_call(window_id, function()
    vim.fn.jobstart(cmd, opts)
  end)
end

return M
