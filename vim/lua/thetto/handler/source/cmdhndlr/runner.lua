local M = {}

function M.collect()
  local items = {}
  for _, runner in ipairs(require("cmdhndlr").runners()) do
    table.insert(items, { value = runner.name })
  end
  return items
end

M.kind_name = "word"

return M
