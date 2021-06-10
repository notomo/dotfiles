xmap <Space>S <Plug>(neosnippet_expand_target)
nnoremap [file]s <Cmd>NeoSnippetEdit<CR>
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory = '~/.vim/snippets/'
let g:neosnippet#disable_runtime_snippets = {'_' : 1}
function! s:complete() abort
    if neosnippet#expandable()
        return "\<Plug>(neosnippet_expand)"
    endif
    if exists('v:completed_item') && !empty(v:completed_item)
        return "\<C-y>\<Plug>(neosnippet_expand)"
    endif
    return "\<C-n>\<C-y>\<Plug>(neosnippet_expand)"
endfunction
imap <expr> j<Space>o <SID>complete()
