local M = {}

function M.collect()
  local items = {}
  local plugins = require("optpack").list()
  for _, plugin in ipairs(plugins) do
    table.insert(items, { value = plugin.full_name, path = plugin.directory })
  end
  return items
end

M.kind_name = "file/directory"

return M
