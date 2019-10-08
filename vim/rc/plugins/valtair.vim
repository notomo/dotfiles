
autocmd MyAuGroup FileType valtair call s:settings()
function! s:settings() abort
    nnoremap <buffer> j <Cmd>ValtairDo next<CR>
    nnoremap <buffer> k <Cmd>ValtairDo prev<CR>
    nnoremap <buffer> h <Cmd>ValtairDo left<CR>
    nnoremap <buffer> l <Cmd>ValtairDo right<CR>
    nnoremap <buffer> q <Cmd>ValtairDo quit<CR>
endfunction
