
if executable('gopls')
    augroup LspGo
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'go-lang',
            \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
            \ 'whitelist': ['go'],
        \ })
    augroup END
endif
if executable('pyls')
    augroup LspPython
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ 'workspace_config': {
                \ 'pyls': {
                    \ 'plugins': {
                        \ 'jedi_definition': {'follow_imports' : v:true, 'follow_builtin_imports' : v:true}
                    \ }
                \ }
            \ }
        \})
    augroup END
endif
if executable('rls')
    augroup LspRust
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'rls',
            \ 'cmd': {server_info->['rls']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
            \ 'whitelist': ['rust'],
        \ })
    augroup END
endif

if executable('vls')
    augroup LspVue
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'vls',
            \ 'cmd': {server_info->['vls']},
            \ 'whitelist': ['vue'],
            \ 'initialization_options': {
                \ 'config': {
                    \ 'html': {},
                    \ 'vetur': {'validation': {}},
                \ }
            \ }
        \ })
    augroup END
endif

let g:lsp_diagnostics_enabled = 0
let g:lsp_signs_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0

nnoremap [lc] <Nop>
nmap <Leader>f [lc]
nnoremap <silent> [lc]d :<C-u>LspDefinition<CR>
nnoremap <silent> [lc]D :<C-u>LspTypeDefinition<CR>
nnoremap <silent> [lc]r :<C-u>LspRename<CR>
nnoremap <silent> [lc]k :<C-u>LspHover<CR>
nnoremap <silent> [lc]ld :<C-u>LspDocumentSymbol<CR>
nnoremap <silent> [lc]lw :<C-u>LspWorkspaceSymbol<CR>
nnoremap <silent> [exec]gr :<C-u>LspReferences<CR>
nnoremap <silent> [exec]gi :<C-u>LspImplementation<CR>
