local util = require("notomo.plugin.thetto.util")

local M = {}

function M.collect(self)
  local current_path = vim.fn.expand("%:p")
  return function(observer)
    local method = "textDocument/documentSymbol"
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    local _, cancel = vim.lsp.buf_request(self.bufnr, method, params, function(_, result)
      local items = {}
      for _, v in ipairs(result or {}) do
        vim.list_extend(items, self:_to_items(v, "", current_path))
      end
      observer:next(items)
      observer:complete()
    end)
    return cancel
  end
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

M.highlight = require("thetto.util").highlight.columns({
  {
    group = "Statement",
    start_key = "kind",
  },
})

M.kind_name = "file"

return M
