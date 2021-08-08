local util = require("notomo/thetto_util")

local M = {}

function M._to_item(self, opts)
  local to_relative = self.pathlib.relative_modifier(opts.cwd)
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
  local result = self.opts.result or {}
  local to_item = self:_to_item(opts)

  local items = {}
  for _, v in ipairs(result) do
    table.insert(items, to_item(v))
  end
  return items
end

M.kind_name = "file"

return M
