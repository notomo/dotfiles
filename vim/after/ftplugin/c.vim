setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
call notomo#mapping#lsp()
nnoremap <buffer> [finder]o <Cmd>lua vim.lsp.buf.document_symbol()<CR>
