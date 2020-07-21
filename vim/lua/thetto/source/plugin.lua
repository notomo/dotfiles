local M = {}

M.make = function()
  local items = {}
  local plugins = vim.tbl_values(vim.fn["minpac#getpluglist"]())
  for _, plugin in ipairs(plugins) do
    local path = plugin.dir
    local factors = vim.split(plugin.url, "/", true)
    local name = table.concat({unpack(factors, #factors - 1, #factors)}, "/")
    if vim.endswith(name, ".git") then
      name = name:sub(1, #name - #(".git"))
    end
    table.insert(items, {value = name, path = path})
  end
  return items
end

M.kind_name = "directory"

return M
