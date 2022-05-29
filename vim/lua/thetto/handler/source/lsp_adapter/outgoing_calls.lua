local pathlib = require("thetto.lib.path")
local util = require("notomo.plugin.thetto.util")

local M = {}

function M.collect(self, opts)
  local to_relative = pathlib.relative_modifier(opts.cwd)
  local path = self.opts.path
  local relative_path = to_relative(path)

  local items = {}
  for _, call in pairs(self.opts.result or {}) do
    local call_hierarchy = call["to"]
    for _, range in pairs(call.fromRanges) do
      local row = range.start.line + 1
      local value = call_hierarchy.name
      local path_with_row = ("%s:%d"):format(relative_path, row)
      table.insert(items, {
        path = path,
        desc = ("%s %s()"):format(path_with_row, value),
        value = value,
        row = row,
        range = util.range(range),
        column_offsets = {
          ["path:relative"] = 0,
          value = #path_with_row + 1,
        },
      })
    end
  end
  return items
end

M.highlight = require("thetto.util").highlight.columns({
  {
    group = "Comment",
    end_key = "value",
  },
})

M.kind_name = "file"
M.sorters = { "row" }

return M
