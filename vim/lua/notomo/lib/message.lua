local M = {}

local plugin_name = vim.split((...):gsub("%.", "/"), "/", { plain = true })[1]
local prefix = ("[%s] "):format(plugin_name)

function M.warn(msg)
  vim.notify(M.wrap(msg), vim.log.levels.WARN)
end

function M.info(msg)
  vim.notify(M.wrap(msg))
end

function M.wrap(msg)
  if type(msg) == "string" then
    return prefix .. msg
  end
  return prefix .. vim.inspect(msg)
end

return M
