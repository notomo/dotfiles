local pathlib = require("thetto.lib.path")
local util = require("notomo.plugin.thetto.util")

local M = {}

function M.collect(self, opts)
  local to_relative = pathlib.relative_modifier(opts.cwd)

  local items = {}
  for _, call in pairs(self.opts.result or {}) do
    local call_hierarchy = call["from"]
    for _, range in pairs(call.fromRanges) do
      local path = vim.uri_to_fname(call_hierarchy.uri)
      local relative_path = to_relative(path)
      local row = range.start.line + 1
      local path_with_row = ("%s:%d"):format(relative_path, row)
      table.insert(items, {
        path = path,
        value = ("%s %s()"):format(path_with_row, call_hierarchy.name),
        row = row,
        range = util.range(range),
        column_offsets = { value = #path_with_row + 1 },
      })
    end
  end
  return items
end

function M.highlight(self, bufnr, first_line, items)
  local highlighter = self.highlights:create(bufnr)
  for i, item in ipairs(items) do
    highlighter:add("Comment", first_line + i - 1, 0, item.column_offsets.value)
  end
end

M.kind_name = "file"
M.sorters = { "row" }

return M
