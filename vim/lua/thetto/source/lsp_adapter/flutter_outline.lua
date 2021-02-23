local M = {}

M._element_key = "dartElement"
M._result_key = "_thetto_flutter_outline"

M.collect = function(self, opts)
  return require("thetto/source/lsp_adapter/dart_outline").collect(self, opts)
end

M.highlight = function(self, bufnr, items)
  return require("thetto/source/lsp_adapter/dart_outline").highlight(self, bufnr, items)
end

M.kind_name = "file"

return M
