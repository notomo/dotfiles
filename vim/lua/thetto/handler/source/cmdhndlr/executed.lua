local M = {}

function M.collect()
  local items = {}
  for _, runner in ipairs(require("cmdhndlr").executed_runners()) do
    table.insert(items, {value = runner.name, bufnr = runner.bufnr})
  end
  return items
end

M.kind_name = "vim/buffer"

return M
