
" let g:jedi#force_py_version = 3
" autocmd FileType python setlocal omnifunc=jedi#completions
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#rename_command = '<Nop>'
" let g:jedi#popup_select_first = 0
" let g:jedi#documentation_command='<Nop>'

" docstring‚Í•\Ž¦‚µ‚È‚¢
" autocmd FileType python setlocal completeopt-=preview

set completeopt-=preview
let s:bundle=neobundle#get('jedi-vim')
function! s:bundle.hooks.on_source(bundle)
    let g:jedi#completions_enabled = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#rename_command = '<Nop>'
    let g:jedi#popup_select_first = 0
    let g:jedi#documentation_command='<Nop>'
    let g:jedi#force_py_version = 3
    " docstring‚Í•\Ž¦‚µ‚È‚¢
    setlocal completeopt-=preview
    let g:jedi#goto_command='<Nop>'
    setlocal omnifunc=jedi#completions
endfunction
unlet s:bundle
nnoremap <Space>im yyp0wWDi<Space>import<Space>
nnoremap <Space>ia 0wyE/from <C-r>" import<CR><C-o>$ByE<C-i>$a,<ESC>p:noh<CR><C-o>dd<C-i>
