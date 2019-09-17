
autocmd MyAuGroup FileType kiview call s:settings()
function! s:settings() abort
    nnoremap <buffer> l <Cmd>Kiview do child<CR>
    nnoremap <buffer> h <Cmd>Kiview do parent<CR>
endfunction
