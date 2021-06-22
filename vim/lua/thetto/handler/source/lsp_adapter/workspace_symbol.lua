local util = require("notomo/thetto_util")

local M = {}

function M._to_item(self, opts)
  local to_relative = self.pathlib.relative_modifier(opts.cwd)
  return function(v)
    local kind = vim.lsp.protocol.SymbolKind[v.kind]
    local path = vim.uri_to_fname(v.location.uri)
    local relative_path = to_relative(path)
    local row = v.location.range.start.line + 1
    local path_row = ("%s:%d"):format(relative_path, row)
    local desc = ("%s %s [%s]"):format(path_row, v.name, kind)
    return {
      path = path,
      row = row,
      column = v.location.range.start.character + 1,
      desc = desc,
      value = v.name,
      column_offsets = {value = #path_row + 1, kind = #desc - #kind - 2},
      range = util.range(v.location.range),
    }
  end
end

function M.collect(self, opts)
  local result = self.opts.result
  local to_item = self:_to_item(opts)

  local items = {}
  for _, v in ipairs(result) do
    table.insert(items, to_item(v))
  end
  return items
end

function M.highlight(self, bufnr, first_line, items)
  local highlighter = self.highlights:create(bufnr)
  for i, item in ipairs(items) do
    highlighter:add("Comment", first_line + i - 1, 0, item.column_offsets.value - 1)
    highlighter:add("Statement", first_line + i - 1, item.column_offsets.kind, -1)
  end
end

M.kind_name = "file"

return M
