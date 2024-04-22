local M = {}

function M.run(cmd, raw_opts)
  local cmd_name = table.concat(cmd, " ")
  local prefix = ("[%s]: "):format(cmd_name)
  local opts = {
    on_exit = function(_, code)
      vim.api.nvim_echo({ { prefix .. ("exit: %d"):format(code) } }, true, {})
    end,
    on_stdout = function(_, data, _)
      data = vim
        .iter(data)
        :filter(function(v)
          return v ~= ""
        end)
        :totable()
      for _, msg in ipairs(data) do
        vim.api.nvim_echo({ { prefix .. msg } }, true, {})
      end
    end,
    on_stderr = function(_, data, _)
      data = vim
        .iter(data)
        :filter(function(v)
          return v ~= ""
        end)
        :totable()
      for _, msg in ipairs(data) do
        vim.api.nvim_echo({ { prefix .. msg, "WarningMsg" } }, true, {})
      end
    end,
    stderr_buffered = true,
    stdout_buffered = true,
  }
  opts = vim.tbl_deep_extend("force", opts, raw_opts or {})
  vim.fn.jobstart(cmd, opts)
end

return M
