local pathlib = require("thetto.lib.path")
local util = require("notomo.plugin.thetto.util")

local M = {}

function M._to_item(_, opts)
  local to_relative = pathlib.relative_modifier(opts.cwd)
  return function(v)
    local path = vim.uri_to_fname(v.uri)
    local relative_path = to_relative(path)
    local row = v.range.start.line + 1
    return {
      value = ("%s:%d"):format(relative_path, row),
      path = path,
      row = row,
      range = util.range(v.range),
    }
  end
end

function M.collect(self, opts)
  local result = type(self.opts.result) == "table" and self.opts.result or {}
  local to_item = self:_to_item(opts)

  local items = {}
  for _, v in ipairs(result) do
    table.insert(items, to_item(v))
  end
  return items
end

M.kind_name = "file"

return M
