
if !has('nvim-0.2.1')
    finish
endif

if has('unix') && executable('xclip')
    let g:clipboard = {
        \ 'name': 'xclip_in_vagrant',
        \ 'copy': {'+': 'xclip -d :0 -i -selection c', '*': 'xclip -d :0 -i -selection c'},
        \ 'paste': {'+': 'xclip -d :0 -o -selection c', '*': 'xclip -d :0 -o -selection c'},
        \ 'cache_enabled': 1,
    \ }
endif

