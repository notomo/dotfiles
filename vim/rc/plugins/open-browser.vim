nnoremap [browser] <Nop>
nmap [exec]b [browser]
xnoremap [browser] <Nop>
xmap [exec]b [browser]

nnoremap [browser]s <Cmd>execute 'OpenBrowserSearch' expand('<cword>')<CR>
nnoremap [browser]o <Cmd>execute 'OpenBrowser' expand('<cWORD>')<CR>
nnoremap [browser]i :<C-u>OpenBrowserSearch<Space>

if !empty($SSH_CLIENT) && has('mac') && executable('lemonade')
    let g:openbrowser_browser_commands = [{'name': 'lemonade', 'args': 'lemonade open {uri}'}]
elseif has('wsl')
    let g:openbrowser_browser_commands = [{'name': 'wslview', 'args': 'wslview {uri}'}]
endif
