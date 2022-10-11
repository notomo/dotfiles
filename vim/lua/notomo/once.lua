local M = {}

-- use global to reload all lua package
vim.g._notomo_once_called = vim.g._notomo_once_called or {}

function M.new(f, key)
  vim.validate({
    f = { f, "function" },
    key = { key, "string" },
  })
  local tbl = { _f = f, _key = key }
  return setmetatable(tbl, M)
end

function M.__call(self, ...)
  if vim.g._notomo_once_called[self._key] then
    return
  end

  local called = vim.g._notomo_once_called
  called[self._key] = true
  vim.g._notomo_once_called = called

  self._f(...)
end

return M
