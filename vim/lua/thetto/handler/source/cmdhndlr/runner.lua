local M = {}

function M.collect()
  local items = {}
  for _, runner in ipairs(require("cmdhndlr").runners()) do
    table.insert(items, {
      value = runner.name,
      path = runner.path,
    })
  end
  return items
end

M.kind_name = "file"
M.default_action = "execute"

M.actions = {
  action_execute = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdhndlr").execute(item.value)
  end,
}

return M
