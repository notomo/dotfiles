local M = {}

function M.collect()
  local items = {}
  local path = vim.fn.expand("$DOTFILES/ansible/roles")
  for _, dir in ipairs(vim.fn.readdir(path)) do
    table.insert(items, { value = dir, path = path .. "/" .. dir })
  end
  return items
end

M.kind_name = "ansible/role"

return M
