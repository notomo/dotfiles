local M = {}

function M.publish_diagnostics(err, result, ctx)
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
  vim.diagnostic.setloclist({
    open = false,
    namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id),
  })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
  M.publish_diagnostics(...)
end

return M
