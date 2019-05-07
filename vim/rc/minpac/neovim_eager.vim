call minpac#add('Shougo/denite.nvim')

call minpac#add('notomo/denite-autocmd')
nnoremap <silent> [denite]a :<C-u>Denite autocmd<CR>

call minpac#add('notomo/denite-runtimepath')
nnoremap <silent> [denite]R :<C-u>Denite runtimepath<CR>

call minpac#add('pocari/vim-denite-emoji')
call minpac#add('junegunn/vim-emoji')
nnoremap <silent> [denite]e :<C-u>Denite emoji<CR>

call minpac#add('vim-jp/vimdoc-ja')

call minpac#add('notomo/denite-keymap')
nnoremap <silent> [denite]m :<C-u>Denite keymap:n<CR>

call minpac#add('thinca/vim-themis')

call minpac#add('sheerun/vim-polyglot')
let g:polyglot_disabled = ['markdown', 'jsx']

call minpac#add('numirias/semshi')
let g:semshi#simplify_markup = v:false
let g:semshi#tolerate_syntax_errors = v:false

if has('unix')
    call minpac#add('lambdalisue/suda.vim')
    let g:suda_startup = 1
    nnoremap [file]W :<C-u>write suda://%<CR>
endif

if executable('look')
    call minpac#add('ujihisa/neco-look')
endif

call minpac#add('w0rp/ale')
source ~/.vim/rc/plugins/ale.vim

call minpac#add('notomo/curstr.nvim')
nnoremap <silent> [keyword]fo :<C-u>Curstr openable -action=open<CR>
nnoremap <silent> [keyword]ft :<C-u>Curstr openable -action=tab_open<CR>
nnoremap <silent> [keyword]fv :<C-u>Curstr openable -action=vertical_open<CR>
nnoremap <silent> [keyword]fh :<C-u>Curstr openable -action=horizontal_open<CR>
nnoremap <silent> [edit]s :<C-u>Curstr togglable<CR>

call minpac#add('notomo/ctrlb.nvim', {'do' : '!npm run setup'})
nnoremap <expr> [exec]cb ":\<C-u>CtrlbOpenLayout ~/dotfiles/vim/rc/plugins/ctrlb_layout.json\<CR>"
nnoremap [exec]c<CR> :<C-u>CtrlbClearAll<CR>
nnoremap [exec]cc :<C-u>CtrlbOpen ctrl<CR>

call minpac#add('notomo/gesture.nvim', {'do' : '!npm run setup'})
noremap <silent> <LeftDrag> :<C-u>call gesture#draw()<CR>
noremap <silent> <LeftRelease> :<C-u>call gesture#finish()<CR>

if executable('python3.6') || executable('python3.7')
    call minpac#add('Shougo/defx.nvim')
endif

call minpac#add('janko-m/vim-test')
nnoremap [test]n :<C-u>TestNearest<CR>
nnoremap [test]f :<C-u>TestFile<CR>
nnoremap [test]s :<C-u>TestSuite<CR>
nnoremap [test]l :<C-u>TestLast<CR>
nnoremap [test]v :<C-u>TestVisit<CR>
nnoremap [test]C :<C-u>call notomo#vim_test#toggle_coverage()<CR>
source ~/.vim/rc/plugins/vim_test.vim
if !exists('g:test#runners')
    let g:test#runners = {}
endif
let g:test#runners['PHP'] = ['PHPUnit']
let g:test#runners['Python'] = ['PyTest']
let g:test#runners['JavaScript'] = ['Jest']
let g:test#python#pytest#options = '-s'
let g:test#php#phpunit#options = '--no-coverage'
let g:test#go#gotest#options = '-v'

call minpac#add('Shougo/deoplete.nvim')
let g:deoplete#enable_at_startup = 1

call minpac#add('mhartington/nvim-typescript')

" call minpac#add('autozimu/LanguageClient-neovim', {'branch' : 'next', 'do' : '!bash install.sh'})
"
" nnoremap [lc] <Nop>
" nmap <Leader>f [lc]
" nnoremap <silent> [lc]d :<C-u>call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> [lc]D :<C-u>call LanguageClient_textDocument_typeDefinition()<CR>
" nnoremap <silent> [lc]r :<C-u>call LanguageClient_textDocument_rename()<CR>
" nnoremap <silent> [lc]k :<C-u>call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> [denite]ld :<C-u>Denite documentSymbol<CR>
" nnoremap <silent> [denite]lw :<C-u>Denite workspaceSymbol<CR>
" nnoremap <silent> [denite]lr :<C-u>Denite references -auto-preview -immediately-1<CR>
"
" let g:LanguageClient_autoStart = 1
"
" let g:LanguageClient_serverCommands = {}
" " let g:LanguageClient_serverCommands['go'] = ['golsp', '-mode', 'stdio']
" " let g:LanguageClient_serverCommands['python'] = ['pyls']
" " let g:LanguageClient_serverCommands['javascript'] = ['javascript-typescript-stdio']
" " let g:LanguageClient_serverCommands['lua'] = ['lua-lsp']
" " let g:LanguageClient_serverCommands['rust'] = ['rustup', 'run', 'nightly', 'rls']
" " let g:LanguageClient_serverCommands['haskell'] = ['hie', '--lsp']
" " let g:LanguageClient_serverCommands['vue'] = ['vls']
"
" let g:LanguageClient_signColumnAlwaysOn = 0
" let g:LanguageClient_diagnosticsEnable = 0
"
" let g:LanguageClient_loggingLevel = 'INFO'

call minpac#add('ruanyl/vim-gh-line')
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0
let g:gh_always_interactive = 1
if !has('mac') && has('unix') && executable('xclip')
    let g:gh_open_command = 'fn() { echo "$@" | xclip -d :0 -i -selection c; }; fn '
elseif has('mac') && executable('lemonade')
    let g:gh_open_command = 'fn() { echo "$@" | lemonade copy; }; fn '
elseif has('win32')
    let g:gh_open_command = 'fn() { echo "$@" | win32yank -i --crlf; }; fn '
endif
nnoremap [yank]U :<C-u>GHYank<CR>
xnoremap [yank]U :GHYank<CR>

function! s:yank_and_echo(line1, line2) abort range
    if a:line1 == a:line2
        execute 'GH'
    else
        execute a:line1 . ',' . a:line2 . 'GH'
    endif
    let value = @+
    echomsg 'yank '. trim(value)
endfunction

command! -range GHYank call s:yank_and_echo(<line1>, <line2>)

call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
if executable('bingo')
    augroup LspGo
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'go-lang',
            \ 'cmd': {server_info->['bingo', '-mode', 'stdio']},
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

call minpac#add('fatih/vim-go')
let g:go_auto_type_info = 0
let g:go_auto_sameids = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_fmt_autosave = 0
let g:go_list_type = 'quickfix'
let g:go_snippet_engine = ''
let g:go_gocode_unimported_packages = 0
let g:go_template_autocreate = 0
let g:go_info_mode = 'guru'

call minpac#add('lighttiger2505/deoplete-vim-lsp')

call minpac#add('notomo/vimonga')
