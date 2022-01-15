vim.keymap.set("n", "[finder]o", [[<Cmd>lua vim.lsp.buf.document_symbol()<CR>]], { buffer = true })
