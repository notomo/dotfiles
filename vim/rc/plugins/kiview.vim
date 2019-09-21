
autocmd MyAuGroup FileType kiview call s:settings()
function! s:settings() abort
    nnoremap <buffer> l <Cmd>Kiview child<CR>
    nnoremap <buffer> h <Cmd>Kiview parent<CR>
    nnoremap <buffer> q <Cmd>Kiview quit<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
endfunction
