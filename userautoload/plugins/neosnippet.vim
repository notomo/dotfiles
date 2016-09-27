" imap <C-S-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-S-k> <Plug>(neosnippet_expand_or_jump)
xmap <Space>S <Plug>(neosnippet_expand_target)

nnoremap <Space>es :<C-u>:NeoSnippetEdit<CR>

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let s:bundle=neobundle#get('neosnippet')
function! s:bundle.hooks.on_source(bundle)
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif
    " �X�j�y�b�g�t�@�C���̏ꏊ�w��
    let g:neosnippet#snippets_directory='~/.vim/snippets/'
    let g:neosnippet#disable_runtime_snippets = {
            \   '_' : 1,
            \ }
endfunction
unlet s:bundle

