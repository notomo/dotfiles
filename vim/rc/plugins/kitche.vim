
nnoremap [exec], <Cmd>KitcheOpen makefile<CR>

autocmd MyAuGroup FileType kitche-makefile call s:settings()
function! s:settings() abort
    nnoremap <buffer> <CR> <Cmd>KitcheServe<CR>
    inoremap <buffer> <CR> <Cmd>KitcheServe<CR>
    nnoremap <buffer> q <Cmd>quit<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
endfunction
