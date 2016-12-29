
autocmd MyAuGroup FileType vimshell call s:shell_my_settings()
function! s:shell_my_settings()"{{{
    nnoremap <buffer> <Space>uh G:<C-u>Unite vimshell/history<CR>
    nmap <buffer> <C-S-l> Gddih<Plug>(vimshell_enter)
    imap <buffer> <C-S-l> <ESC>Gddih<Plug>(vimshell_enter)
    inoremap <buffer> <C-w> <ESC>:<C-u>q<CR>
endfunction"}}}

