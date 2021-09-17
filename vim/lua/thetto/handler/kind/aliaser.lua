local M = {}

function M.action_call(_, items)
  for _, item in ipairs(items) do
    item.alias:call()
  end
end

M.default_action = "call"

return M
