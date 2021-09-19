local M = {}

function M.action_call(_, items)
  for _, item in ipairs(items) do
    local alias = item.alias
    if alias:need_args() then
      local line = require("aliaser").to_string(alias)
      return require("cmdbuf").split_open(vim.o.cmdwinheight, {line = line, type = "lua/cmd"})
    end
    alias:call()
  end
end

M.default_action = "call"

return M
