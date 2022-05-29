local M = {}

M._element_key = "dartElement"
M._result_key = "_thetto_flutter_outline"

M.collect = require("thetto.handler.source.lsp_adapter.dart_outline").collect
M.highlight = require("thetto.handler.source.lsp_adapter.dart_outline").highlight

M.kind_name = "file"

return M
