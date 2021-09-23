local M = {}

function M.run(cmd)
  local cmd_name = table.concat(cmd, " ")
  local prefix = ("[%s]: "):format(cmd_name)
  vim.fn.jobstart(cmd, {
    on_exit = function()
    end,
    on_stdout = function(_, data, _)
      data = vim.tbl_filter(function(v)
        return v ~= ""
      end, data)
      for _, msg in ipairs(data) do
        vim.api.nvim_echo({{prefix .. msg}})
      end
    end,
    on_stderr = function(_, data, _)
      data = vim.tbl_filter(function(v)
        return v ~= ""
      end, data)
      for _, msg in ipairs(data) do
        vim.api.nvim_echo({{prefix .. msg, "WarningMsg"}})
      end
    end,
    stderr_buffered = true,
    stdout_buffered = true,
  })
end

return M
