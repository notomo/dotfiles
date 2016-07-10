nnoremap [browser] <Nop>
nmap <Leader>q [browser]
vnoremap [browser] <Nop>
vmap <Leader>q [browser]

nmap [browser]x <Plug>(openbrowser-smart-search)
vmap [browser]x <Plug>(openbrowser-smart-search)
nmap [browser]o <Plug>(openbrowser-open)
vmap [browser]o <Plug>(openbrowser-open)
nnoremap [browser]s :<C-u>OpenBrowserSearch<Space>

map <3-LeftMouse> <Plug>(openbrowser-smart-search)
imap <3-LeftMouse> <Plug>(openbrowser-smart-search)

command! OpenBrowserCurrent execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')
nnoremap [browser]c :<C-u>OpenBrowserCurrent<CR>
