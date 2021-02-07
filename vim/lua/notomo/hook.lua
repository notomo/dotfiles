local M = {}

local RequireHook = {}
RequireHook.__index = RequireHook
M.RequireHook = RequireHook

function RequireHook.create(plugin_name, module_name)
  local root = vim.split(module_name:gsub("/", "."), ".", true)[1]
  local tbl = {_plugin_name = plugin_name, _root_module_name = root, _loaded = false}
  local self = setmetatable(tbl, RequireHook)

  self._f = function(required_name)
    self:_hook(required_name)
  end

  table.insert(package.loaders, 1, self._f)
end

function RequireHook._hook(self, required_name)
  if self._loaded then
    return nil
  end

  local name = vim.split(required_name:gsub("/", "."), ".", true)[1]
  if self._root_module_name ~= name then
    return nil
  end
  self._loaded = true
  vim.cmd("packadd " .. self._plugin_name)

  vim.schedule(function()
    self:_remove()
  end)
end

function RequireHook._remove(self)
  local index
  for i, loader in ipairs(package.loaders) do
    if loader == self._f then
      index = i
      break
    end
  end
  if index then
    table.remove(package.loaders, index)
  end
end

return M
