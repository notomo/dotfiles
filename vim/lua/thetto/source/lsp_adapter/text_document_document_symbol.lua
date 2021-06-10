local util = require("notomo/thetto_util")

local M = {}

M._to_item = function()
  local current_path = vim.fn.expand("%:p")
  return function(v)
    local kind = vim.lsp.protocol.SymbolKind[v.kind]
    local desc = ("%s %s [%s]"):format(v.name, v.detail or "", kind)
    local range = v.selectionRange or v.location.range
    return {
      path = current_path,
      row = range.start.line + 1,
      column = range.start.character + 1,
      desc = desc,
      value = v.name,
      column_offsets = {value = 0, kind = #desc - #kind - 2},
      range = util.range(v.selectionRange),
    }
  end
end

M.collect = function(self)
  local result = self.opts.result
  local to_item = self:_to_item()

  local items = {}
  for _, v in ipairs(result) do
    table.insert(items, to_item(v))
  end
  return items
end

M.highlight = function(self, bufnr, first_line, items)
  local highlighter = self.highlights:create(bufnr)
  for i, item in ipairs(items) do
    highlighter:add("Statement", first_line + i - 1, item.column_offsets.kind, -1)
  end
end

M.kind_name = "file"

return M
