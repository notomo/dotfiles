
nnoremap [exec], <Cmd>Kitche open makefile packagejson<CR>
nnoremap ss <Cmd>Kitche open substitute<CR>
xnoremap ss :Kitche open substitute<CR>

autocmd MyAuGroup FileType kitche-* call s:settings()
function! s:settings() abort
    nnoremap <buffer> <CR> <Cmd>Kitche serve<CR>
    inoremap <buffer> <CR> <Cmd>Kitche serve<CR>
    nnoremap <buffer> t<Space> <Cmd>Kitche look<CR>
    nnoremap <buffer> o <Cmd>Kitche look<CR>
    nnoremap <buffer> q <Cmd>quit<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
endfunction
