
autocmd MyAuGroup FileType gitcommit call s:gitcommit_my_settings()
function! s:gitcommit_my_settings()"{{{
    nmap <buffer> <Leader>ga -
    nmap <buffer> dd D
    nmap <buffer> o O
    nmap <buffer> j <C-N>
    nmap <buffer> k <C-P>
    vmap <buffer> <Leader>ga -
endfunction"}}}
