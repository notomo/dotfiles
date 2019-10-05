
autocmd MyAuGroup FileType valtair call s:settings()
function! s:settings() abort
    nnoremap <buffer> j <Cmd>ValtairDo next<CR>
    nnoremap <buffer> k <Cmd>ValtairDo prev<CR>
endfunction
