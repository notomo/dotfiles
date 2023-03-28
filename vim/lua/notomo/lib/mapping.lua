local M = {}

function M.set_prefix(modes, name, key)
  local name_key = ("[%s]"):format(name)
  vim.keymap.set(modes, name_key, "<Nop>")
  vim.keymap.set(modes, key, name_key, { remap = true })
end

return M
