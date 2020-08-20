local M = {}

M._to_item = function()
  local current_path = vim.fn.expand("%:p")
  return function(v)
    local kind = vim.lsp.protocol.SymbolKind[v.kind]
    local desc = ("%s %s [%s]"):format(v.name, v.detail, kind)
    return {
      path = current_path,
      row = v.selectionRange.start.line + 1,
      column = v.selectionRange.start.character + 1,
      desc = desc,
      value = v.name,
      column_offsets = {value = 0, kind = #desc - #kind - 2},
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

M.highlight = function(self, bufnr, items)
  local ns = self.highlights.reset(bufnr)
  for i, item in ipairs(items) do
    vim.api.nvim_buf_add_highlight(bufnr, ns, "Statement", i - 1, item.column_offsets.kind, -1)
  end
end

M.kind_name = "file"

return M
