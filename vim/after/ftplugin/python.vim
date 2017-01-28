setlocal omnifunc=jedi#completions
" setlocal completeopt-=preview
setlocal expandtab
autocmd MyAuGroup FileType python setlocal completeopt-=preview

" let g:python_highlight_all = 1

nnoremap <Space>im yyp0wWDi<Space>import<Space>
nnoremap <Space>ia 0wyE/from <C-r>" import<CR><C-o>$ByE<C-i>$a,<Space><ESC>p:noh<CR><C-o>dd<C-i>
