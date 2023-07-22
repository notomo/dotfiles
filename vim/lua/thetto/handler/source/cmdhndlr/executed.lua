local M = {}

M.opts = { is_running = nil }

function M.collect(source_ctx)
  return vim
    .iter(require("cmdhndlr").executed_runners())
    :map(function(runner)
      if source_ctx.opts.is_running and not runner.is_running then
        return
      end
      return {
        value = runner.name,
        bufnr = runner.bufnr,
        is_running = runner.is_running,
      }
    end)
    :totable()
end

M.kind_name = "vim/buffer"

return M
