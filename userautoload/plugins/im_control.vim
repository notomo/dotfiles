let s:bundle=neobundle#get('im_control.vim')
function! s:bundle.hooks.on_source(bundle)
    set formatoptions-=r
    set formatoptions-=o
endfunction
unlet s:bundle
