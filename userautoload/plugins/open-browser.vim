nnoremap [browser] <Nop>
nmap <Leader><Space> [browser]
vnoremap [browser] <Nop>
vmap <Leader><Space> [browser]

nmap [browser]x <Plug>(openbrowser-smart-search)
vmap [browser]x <Plug>(openbrowser-smart-search)
nnoremap [browser]s :<C-u>OpenBrowserSearch<Space>

map <2-LeftMouse> <Plug>(openbrowser-smart-search)
imap <2-LeftMouse> <Plug>(openbrowser-smart-search)

command! OpenBrowserCurrent execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')
nnoremap [browser]o :<C-u>OpenBrowserCurrent<CR>
