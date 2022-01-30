local M = {}

function M.collect()
  local items = {}
  local path = vim.fn.expand("%:p")
  local tests, err = require("gettest").all_leaves()
  if err then
    return {}
  end
  for _, test in ipairs(tests) do
    table.insert(items, {
      value = test.name,
      row = test.scope_node:start() + 1,
      path = path,
    })
  end
  return items
end

M.kind_name = "file"

return M
