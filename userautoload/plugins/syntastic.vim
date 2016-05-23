let s:bundle=neobundle#get('syntastic')
function! s:bundle.hooks.on_source(bundle)
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_enable_signs = 1
    let g:syntastic_auto_loc_list = 3
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_python_checkers=['pyflakes']
    let g:syntastic_mode_map = { 'passive_filetypes': ['tex'] }
    " let g:syntastic_javascript_checker = "jshint"
endfunction
unlet s:bundle
