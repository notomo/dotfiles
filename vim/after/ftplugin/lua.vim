setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
nnoremap <buffer> [exec]s :<C-u>luafile %<CR>
nnoremap <buffer> <expr> [exec]l ':lua ' . getline('.') . '<CR>'
call notomo#lsp#mapping()
if has('nvim') && executable('lua-format')
    nnoremap <buffer> [file]w :<C-u>lua require("notomo/vimrc").fmt({'lua-format', '-c', vim.fn.expand('~/dotfiles/tool/.lua-format')})<CR>
endif
