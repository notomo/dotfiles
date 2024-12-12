local M = {}

function M.run(cmd, raw_opts)
  raw_opts = raw_opts or {}

  local cmd_name = table.concat(cmd, " ")
  local prefix = ("[%s]: "):format(cmd_name)

  local notify = raw_opts.notify or vim.notify
  local cwd = raw_opts.cwd or "."
  vim.system(cmd, {
    cwd = cwd,
    stdout = function(_, data)
      if not data then
        return
      end
      vim.schedule(function()
        notify(prefix .. vim.trim(data))
      end)
    end,
    stderr = function(_, data)
      if not data then
        return
      end
      vim.schedule(function()
        notify(prefix .. vim.trim(data), vim.log.levels.WARN)
      end)
    end,
  }, function(o)
    vim.schedule(function()
      notify(prefix .. ("exit: %d"):format(o.code))
    end)
  end)
end

return M
