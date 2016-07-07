setlocal omnifunc=jedi#completions
" docstringは表示しない
setlocal completeopt-=preview
setlocal expandtab

nnoremap <Space>im yyp0wWDi<Space>import<Space>
nnoremap <Space>ia 0wyE/from <C-r>" import<CR><C-o>$ByE<C-i>$a,<ESC>p:noh<CR><C-o>dd<C-i>
