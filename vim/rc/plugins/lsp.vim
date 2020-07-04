lua require 'notomo/lsp'

nnoremap [lc] <Nop>
nmap <Leader>f [lc]

nnoremap <silent> [lc]d <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> [lc]k  <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> [lc]D <Cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> [lc]K  <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> [lc]s <Cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>
nnoremap <silent> [exec]gr <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> [exec]gn <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> [exec]gd <Cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> [exec]gw <Cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> [keyword]c <Cmd>lua vim.lsp.buf.code_action()<CR>

highlight! link LspDiagnosticsError SpellBad
highlight! link LspDiagnosticsWarning Tag
