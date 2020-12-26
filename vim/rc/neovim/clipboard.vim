if has('win32')
    let g:clipboard = {
        \ 'name': 'win32yank',
        \ 'copy': {'+': 'win32yank -i --crlf', '*': 'win32yank -i --crlf'},
        \ 'paste': {'+': 'win32yank -o --lf', '*': 'win32yank -o --lf'},
        \ 'cache_enabled': 0,
    \ }
endif
