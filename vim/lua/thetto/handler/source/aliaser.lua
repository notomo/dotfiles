local M = {}

function M.collect()
  return vim
    .iter(require("aliaser").list({ "notomo.plugin.aliaser" }))
    :map(function(alias)
      return {
        value = alias.name,
        alias = alias,
        row = alias.start_row,
        path = alias.file_path,
      }
    end)
    :totable()
end

M.kind_name = "file"

M.actions = {
  action_call = function(items)
    for _, item in ipairs(items) do
      local alias = item.alias
      if alias.params_count > 0 then
        local line = require("aliaser").to_string(alias)
        return require("notomo.lib.cmdwin").open({ line = "lua " .. line, type = "lua" })
      end
      alias.call()
    end
  end,
  default_action = "call",
}

return M
