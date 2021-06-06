nmap r <Plug>(operator-replace)
xmap r <Plug>(operator-replace)
omap r <Plug>(operator-replace)
onoremap <Plug>(builtin-gn) gn
nnoremap <Plug>(builtin-/) /
nnoremap <Plug>(builtin-N) N
nmap [edit]n *<Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)
xmap <expr> [edit]n "\<ESC><Plug>(builtin-/)\<C-r>=<SID>search()\<CR>\<CR><Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)"
xnoremap <expr> [edit]d "\<ESC>/\<C-r>=<SID>search()\<CR>\<CR>N\"_cgn"
function! s:search() abort
    let tmp = @"
    normal! gv""y
    let [text, @"] = [escape(@", '\/'), tmp]
    return '\V' .. substitute(text, "\n", '\\n', 'g')
endfunction
