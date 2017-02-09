
autocmd MyAuGroup FileType gita-status call s:gita_status_settings()
function! s:gita_status_settings()
    nmap <buffer> <Leader>ga <Plug>(gita-index-toggle)
    nmap <buffer> U <Plug>(gita-discard)
    vmap <buffer> <Leader>ga <Plug>(gita-index-toggle)
    vmap <buffer> U <Plug>(gita-discard)
    nmap <buffer> o <Plug>(gita-edit)
    nmap <buffer> cc <Plug>(gita-commit-open)
    nmap <buffer> ca <Plug>(gita-commit-open-amend)
endfunction

autocmd MyAuGroup FileType gita-status call s:gita_branch_settings()
function! s:gita_branch_settings()
    nmap <buffer> rn <Plug>(gita-branch-rename)
    nmap <buffer> co <Plug>(gita-branch-checkout)
endfunction

autocmd MyAuGroup FileType diff call s:diff_settings()
function! s:diff_settings()
    nnoremap <buffer> rl :<C-u>e!<CR>
endfunction
