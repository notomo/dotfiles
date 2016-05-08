
" let g:jedi#force_py_version = 3
" autocmd FileType python setlocal omnifunc=jedi#completions
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#rename_command = '<Nop>'
" let g:jedi#popup_select_first = 0
" let g:jedi#documentation_command='<Nop>'

" docstring�͕\�����Ȃ�
" autocmd FileType python setlocal completeopt-=preview

let s:bundle=neobundle#get('jedi-vim')
function! s:bundle.hooks.on_source(bundle)
    let g:jedi#completions_enabled = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#rename_command = '<Nop>'
    let g:jedi#popup_select_first = 0
    let g:jedi#documentation_command='<Nop>'
    let g:jedi#force_py_version = 3
    " docstring�͕\�����Ȃ�
    setlocal completeopt-=preview
    " set completeopt-=preview
    let g:jedi#goto_command='<Nop>'
    setlocal omnifunc=jedi#completions
endfunction
unlet s:bundle
