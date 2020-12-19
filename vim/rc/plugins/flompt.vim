autocmd MyAuGroup TermOpen * nnoremap <buffer> F <Cmd>Flompt start_sync<CR>

autocmd MyAuGroup FileType flompt call s:flompt_settings()
function! s:flompt_settings() abort
    inoremap <buffer> <CR> <Cmd>Flompt send<CR>
    nnoremap <buffer> <CR> <Cmd>Flompt send<CR>
    nnoremap <buffer> q <Cmd>Flompt close<CR>
endfunction
