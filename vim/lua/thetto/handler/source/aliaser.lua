local M = {}

function M.collect()
  local items = {}
  for _, alias in ipairs(require("aliaser").list()) do
    table.insert(items, {value = alias.name, alias = alias})
  end
  return items
end

M.kind_name = "aliaser"

return M
