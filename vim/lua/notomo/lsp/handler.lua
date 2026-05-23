local M = {}

local ignored_diagnostic = {
  -- diagnostic.source = {diagnostic.code = true}
  deno = { ["import-map-remap"] = true },
}
function M.publish_diagnostics(err, result, ctx)
  result.diagnostics = vim
    .iter(result.diagnostics)
    :filter(function(e)
      return not vim.tbl_get(ignored_diagnostic, e.source, e.code)
    end)
    :totable()

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
