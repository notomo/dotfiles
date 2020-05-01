
nnoremap [exec], <Cmd>KitcheOpen makefile packagejson<CR>

autocmd MyAuGroup FileType kitche-* call s:settings()
function! s:settings() abort
    nnoremap <buffer> <CR> <Cmd>KitcheServe<CR>
    inoremap <buffer> <CR> <Cmd>KitcheServe<CR>
    nnoremap <buffer> t<Space> <Cmd>KitcheLook<CR>
    nnoremap <buffer> o <Cmd>KitcheLook<CR>
    nnoremap <buffer> q <Cmd>quit<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
endfunction
