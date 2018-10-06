
if has('linux') && executable('xclip')
    let g:clipboard = {
        \ 'name': 'xclip_in_vagrant',
        \ 'copy': {'+': 'xclip -d :0 -i -selection c', '*': 'xclip -d :0 -i -selection c'},
        \ 'paste': {'+': 'xclip -d :0 -o -selection c', '*': 'xclip -d :0 -o -selection c'},
        \ 'cache_enabled': 1,
    \ }
elseif has('win32')
    let g:clipboard = {
        \ 'name': 'win32yank',
        \ 'copy': {'+': 'win32yank -i --crlf', '*': 'win32yank -i --crlf'},
        \ 'paste': {'+': 'win32yank -o --lf', '*': 'win32yank -o --lf'},
        \ 'cache_enabled': 0,
    \ }
endif
