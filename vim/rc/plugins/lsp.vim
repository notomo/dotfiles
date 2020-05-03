lua require 'notomo/lsp'

nnoremap <silent> [lc]d <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> [lc]k  <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> [lc]D <Cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> [lc]K  <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> [lc]s :<Cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

highlight! link LspDiagnosticsError SpellBad
highlight! link LspDiagnosticsWarning Tag
