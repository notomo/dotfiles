local util = require("notomo.thetto_util")

local M = {}

function M.collect(self)
  local current_path = vim.fn.expand("%:p")
  local items = {}
  for _, v in ipairs(self.opts.result or {}) do
    vim.list_extend(items, self:_to_items(v, "", current_path))
  end
  return items
end

function M._to_items(self, item, parent_key, current_path)
  local items = {}

  local kind = vim.lsp.protocol.SymbolKind[item.kind]
  local range = item.selectionRange or item.location.range
  local name = parent_key .. item.name
  local detail = item.detail or ""
  local desc = ("%s %s [%s]"):format(name, detail:gsub("\n", "\\n"), kind)
  table.insert(items, {
    path = current_path,
    row = range.start.line + 1,
    column = range.start.character + 1,
    desc = desc,
    value = name,
    column_offsets = { value = 0, kind = #desc - #kind - 2 },
    range = util.range(item.selectionRange),
  })

  for _, v in ipairs(item.children or {}) do
    vim.list_extend(items, self:_to_items(v, name .. ".", current_path))
  end
  return items
end

function M.highlight(self, bufnr, first_line, items)
  local highlighter = self.highlights:create(bufnr)
  for i, item in ipairs(items) do
    highlighter:add("Statement", first_line + i - 1, item.column_offsets.kind, -1)
  end
end

M.kind_name = "file"

return M
