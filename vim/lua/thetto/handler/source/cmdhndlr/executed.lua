local M = {}

M.opts = { is_running = nil }

function M.collect(source_ctx)
  local items = {}
  for _, runner in ipairs(require("cmdhndlr").executed_runners()) do
    local item = { value = runner.name, bufnr = runner.bufnr, is_running = runner.is_running }
    if source_ctx.opts.is_running and not item.is_running then
      goto continue
    end
    table.insert(items, item)
    ::continue::
  end
  return items
end

M.kind_name = "vim/buffer"

return M
