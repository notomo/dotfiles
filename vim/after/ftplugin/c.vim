setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
lua require("notomo.mapping").lsp()
nnoremap <buffer> [finder]o <Cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <buffer> <silent> sgj <Cmd>TSTextobjectGotoNextStart @function.outer<CR>
nnoremap <buffer> <silent> sgk <Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>
