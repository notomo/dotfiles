nnoremap [lc] <Nop>
nmap <Leader>f [lc]
nnoremap <silent> [lc]d :<C-u>call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> [lc]D :<C-u>call LanguageClient_textDocument_typeDefinition()<CR>
nnoremap <silent> [lc]r :<C-u>call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> [lc]k :<C-u>call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> [denite]ld :<C-u>Denite documentSymbol<CR>
nnoremap <silent> [denite]lw :<C-u>Denite workspaceSymbol<CR>
nnoremap <silent> [denite]lr :<C-u>Denite references -auto-preview -immediately-1<CR>

let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands['go'] = ['gopls', '-mode', 'stdio']
let g:LanguageClient_serverCommands['python'] = ['pyls']
let g:LanguageClient_serverCommands['rust'] = ['rls']
let g:LanguageClient_serverCommands['vue'] = ['vls']

let g:LanguageClient_signColumnAlwaysOn = 0
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_autoStart = 1

" lua require'nvim_lsp'.rls.setup{}
" lua require'nvim_lsp'.gopls.setup{}
" lua require'nvim_lsp'.pyls.setup{}
" lua require'nvim_lsp'.clangd.setup{}
"
" lua vim.lsp.set_log_level('error')
"
" nnoremap <silent> [lc]d <Cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> [lc]k  <Cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> [lc]D <Cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> [lc]K  <cmd>lua vim.lsp.buf.signature_help()<CR>
