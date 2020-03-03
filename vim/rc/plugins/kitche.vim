
nnoremap [exec], <Cmd>KitcheOpen makefile<CR>

autocmd MyAuGroup FileType kitche-makefile call s:settings()
function! s:settings() abort
    nnoremap <buffer> <CR> <Cmd>KitcheServe<CR>
    inoremap <buffer> <CR> <Cmd>KitcheServe<CR>
endfunction
