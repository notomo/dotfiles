require("notomo.lsp.mapping").setup()
vim.keymap.set("n", "[finder]o", [[<Cmd>lua vim.lsp.buf.document_symbol()<CR>]], { buffer = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  buffer = 0,
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 3000)
  end,
})
