setlocal completeopt-=preview
nnoremap <buffer> [exec]s :<C-u>luafile %<CR>
call notomo#lsp#mapping()
