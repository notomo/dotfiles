local M = {}

function M.collect()
  local items = {}
  for _, alias in ipairs(require("aliaser").list()) do
    table.insert(items, {
      value = alias.name,
      alias = alias,
      row = alias.start_row,
      path = alias.file_path,
    })
  end
  return items
end

M.kind_name = "file"
M.default_action = "call"

M.actions = {
  action_call = function(_, items)
    for _, item in ipairs(items) do
      local alias = item.alias
      if alias:need_args() then
        local line = require("aliaser").to_string(alias)
        return require("cmdbuf").split_open(vim.o.cmdwinheight, { line = line, type = "lua/cmd" })
      end
      alias:call()
    end
  end,
}

return M
