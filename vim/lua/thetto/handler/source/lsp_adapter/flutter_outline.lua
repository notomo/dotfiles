local M = {}

M.opts = {
  element_key = "dartElement",
  result_key = "_thetto_flutter_outline",
}

function M.collect(source_ctx)
  return require("thetto.handler.source.lsp_adapter.dart_outline").collect(source_ctx)
end
M.highlight = require("thetto.handler.source.lsp_adapter.dart_outline").highlight

M.kind_name = "file"

return M
