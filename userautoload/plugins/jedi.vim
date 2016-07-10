let s:bundle=neobundle#get('jedi-vim')
function! s:bundle.hooks.on_source(bundle)
    " let g:jedi#auto_initialization = 0
    let g:jedi#completions_enabled = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#rename_command = '<Nop>'
    let g:jedi#goto_assignments_command = '<Leader>dp'
    let g:jedi#usages_command = '<Leader>du'
    let g:jedi#popup_select_first = 0
    let g:jedi#documentation_command='<Nop>'
    let g:jedi#force_py_version = 3
    let g:jedi#goto_command='<Nop>'
endfunction
unlet s:bundle
