nnoremap [browser] <Nop>
nmap [exec]b [browser]
xnoremap [browser] <Nop>
xmap [exec]b [browser]

nnoremap [browser]s <Cmd>execute 'OpenBrowserSearch' expand('<cword>')<CR>
nnoremap [browser]o <Cmd>execute 'OpenBrowser' expand('<cword>')<CR>
nnoremap [browser]i :<C-u>OpenBrowserSearch<Space>

if !empty($SSH_CLIENT) && executable('lemonade') && has('mac')
    let g:openbrowser_browser_commands = [{'name': 'lemonade', 'args': 'lemonade open {uri}'}]
elseif executable('wslview')
    let g:openbrowser_browser_commands = [{'name': 'wslview', 'args': 'wslview {uri}'}]
endif
