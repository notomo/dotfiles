" Plugin key-mappings.
imap <C-S-k> <Plug>(neosnippet_expand_or_jump)
smap <C-S-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-S-k> <Plug>(neosnippet_expand_target)
 
nnoremap <Space>es :<C-u>:NeoSnippetEdit<CR>
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
 
let s:bundle=neobundle#get('neosnippet')
function! s:bundle.hooks.on_source(bundle)
    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " スニペットファイルの場所指定
    let g:neosnippet#snippets_directory='~/.vim/snippets/'

    let g:neosnippet#disable_runtime_snippets = {
            \   '_' : 1,
            \ }
    set formatoptions-=r
    set formatoptions-=o
endfunction
unlet s:bundle

