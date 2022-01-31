local M = {}

M.opts = { scoped = false }

function M.collect(self)
  local items = {}
  local path = vim.fn.expand("%:p")
  local tests, err
  if self.opts.scoped then
    tests, err = require("gettest").scope_root_leaves(vim.fn.line("."))
  else
    tests, err = require("gettest").all_leaves()
  end
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
