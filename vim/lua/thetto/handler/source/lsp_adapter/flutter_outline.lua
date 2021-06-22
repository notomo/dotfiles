local M = {}

M._element_key = "dartElement"
M._result_key = "_thetto_flutter_outline"

function M.collect(self, opts)
  return require("thetto/handler/source/lsp_adapter/dart_outline").collect(self, opts)
end

function M.highlight(self, bufnr, items)
  return require("thetto/handler/source/lsp_adapter/dart_outline").highlight(self, bufnr, items)
end

M.kind_name = "file"

return M
