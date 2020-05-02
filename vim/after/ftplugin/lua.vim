setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
nnoremap <buffer> [exec]s :<C-u>luafile %<CR>
call notomo#lsp#mapping()
