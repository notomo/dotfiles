local M = {}

local RequireHook = {}
RequireHook.__index = RequireHook
M.RequireHook = RequireHook

function RequireHook.create(plugin_name, module_name, post_hook_file)
  local root = vim.split(module_name:gsub("/", "."), ".", true)[1]
  local tbl = {
    _plugin_name = plugin_name,
    _root_module_name = root,
    _loaded = false,
    _post_hook_file = post_hook_file,
  }
  local self = setmetatable(tbl, RequireHook)

  self._f = function(required_name)
    local ok = self:_hook(required_name)
    self:_post_hook(ok)
  end

  table.insert(package.loaders, 1, self._f)
end

function RequireHook._hook(self, required_name)
  if self._loaded then
    return false
  end

  local name = vim.split(required_name:gsub("/", "."), ".", true)[1]
  if self._root_module_name ~= name then
    return false
  end
  self._loaded = true
  vim.cmd("packadd " .. self._plugin_name)

  vim.schedule(function()
    self:_remove()
  end)

  return true
end

function RequireHook._post_hook(self, ok)
  if not ok then
    return nil
  end
  if self._post_hook_file then
    dofile(vim.fn.expand(self._post_hook_file))
  end
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
