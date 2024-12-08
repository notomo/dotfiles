local M = {}

function M.setup()
  local bufnr = vim.api.nvim_get_current_buf()
  local group = vim.api.nvim_create_augroup("notomo_lsp_signature_help_" .. bufnr, {})
  vim.api.nvim_create_autocmd({ "InsertEnter", "TextChangedI" }, {
    buffer = bufnr,
    group = group,
    callback = function()
      local client = vim.lsp.get_clients({
        bufnr = bufnr,
        method = vim.lsp.protocol.Methods.textDocument_signatureHelp,
      })[1]
      if not client then
        return
      end

      vim.lsp.buf.signature_help({
        focusable = false,
        silent = true,
      })
    end,
  })
end

return M
