local M = {}

function M.collect()
  return vim
    .iter(require("cmdhndlr").runners())
    :map(function(runner)
      return {
        value = runner.full_name,
        path = runner.path,
      }
    end)
    :totable()
end

M.kind_name = "file"

M.actions = {
  action_execute = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdhndlr").execute(item.value)
  end,
  default_action = "execute",
}

return M
