setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
nnoremap <buffer> [exec]s :<C-u>luafile %<CR>
nnoremap <buffer> <expr> [exec]l ':lua ' . getline('.') . '<CR>'
call notomo#lsp#mapping()
if has('nvim')
    nnoremap <buffer> [file]w :<C-u>call notomo#vimrc#fmt(['luafmt', expand('%:p'), '--indent-count=2'])<CR>
endif
