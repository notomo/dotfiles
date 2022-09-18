local M = {}

function M.path()
  local path = vim.fn.expand("%:p")
  path = path:gsub("\\", "/")
  local module_path = vim.split(path, "/lua/")[2]
  if not module_path then
    return ""
  end
  module_path = module_path:gsub("%.lua$", "")
  module_path = module_path:gsub("/init$", "")
  module_path = module_path:gsub("/", ".")
  return module_path
end

return M
