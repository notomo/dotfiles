local M = {}

function M.collect()
  return vim
    .iter(require("cmdhndlr").executed_runners())
    :map(function(runner)
      return {
        value = runner.full_name,
        bufnr = runner.bufnr,
        is_running = runner.is_running,
      }
    end)
    :totable()
end

M.kind_name = "vim/buffer"

return M
