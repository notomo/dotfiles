require("notomo.lsp.mapping").setup()
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  buffer = 0,
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 3000)
  end,
})
