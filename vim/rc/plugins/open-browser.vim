nnoremap [browser] <Nop>
nmap [exec]b [browser]
xnoremap [browser] <Nop>
xmap [exec]b [browser]

nnoremap <expr> [browser]s ":\<C-u>OpenBrowserSearch " . expand('<cword>') . "\<CR>"
nnoremap <expr> [browser]o ":\<C-u>OpenBrowser " . expand('<cWORD>') . "\<CR>"
nnoremap [browser]i :<C-u>OpenBrowserSearch<Space>

if !empty($SSH_CLIENT) && executable('lemonade') && has('mac')
    let g:openbrowser_browser_commands = [{'name': 'lemonade', 'args': 'lemonade open {uri}'}]
elseif executable('wslview')
    let g:openbrowser_browser_commands = [{'name': 'wslview', 'args': 'wslview {uri}'}]
endif
