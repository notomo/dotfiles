nnoremap [gita] <Nop>
nmap <Space>g [gita]

nnoremap [gita]s :<C-u>Gita status<CR>
nnoremap [gita]p :<C-u>Gita patch<CR>
nnoremap [gita]c :<C-u>Gita commit<CR>
nnoremap [gita]b :<C-u>Gita branch<CR>
nnoremap [gita]d :<C-u>Gita diff-ls origin/HEAD...<CR>

autocmd MyAuGroup FileType gita-status,gita-commit,gita-branch,gita-diff-ls call s:gita_my_settings()
function! s:gita_my_settings()"{{{
    nmap <buffer> gs --
    nmap <buffer> ga <<
    nmap <buffer> gu >>
    nmap <buffer> e ee
    nmap <buffer> gm <Plug>(gita-commit-open-amend)
    nmap <buffer> go <C-^>
    nnoremap <buffer> q :<C-u>q<CR>
endfunction"}}}

