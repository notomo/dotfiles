local M = {}

function M.setup(mapping_opts)
  require("notomo.lsp.mapping").setup(mapping_opts)
  require("notomo.lsp.navigation").setup()
  require("notomo.lsp.signature_help").setup()
end

return M
