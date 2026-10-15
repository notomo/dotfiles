local M = {}

local modify = function(operation, scope)
  return function(name, value)
    vim.api.nvim_set_option_value(name, value, { operation = operation, scope = scope })
  end
end

M.append = modify("append")
M.prepend = modify("prepend")
M.remove = modify("remove")
M.append_local = modify("append", "local")
M.remove_local = modify("remove", "local")

return M
