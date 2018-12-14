call minpac#add('Shougo/neosnippet-snippets')
call minpac#add('vim-jp/vimdoc-ja')

call minpac#add('notomo/denite-keymap')
nnoremap <silent> [denite]m :<C-u>Denite keymap:n<CR>

call minpac#add('thinca/vim-themis')
call minpac#add('aklt/plantuml-syntax')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('posva/vim-vue')
call minpac#add('martinda/Jenkinsfile-vim-syntax')
call minpac#add('chr4/nginx.vim')
call minpac#add('jwalton512/vim-blade')
call minpac#add('vim-scripts/gitignore.vim')

call minpac#add('numirias/semshi')
let g:semshi#simplify_markup = v:false
let g:semshi#tolerate_syntax_errors = v:false

call minpac#add('nikvdp/ejs-syntax')

if has('unix')
    call minpac#add('lambdalisue/suda.vim')
    let g:suda_startup = 1
    nnoremap [file]W :<C-u>write suda://%<CR>
endif

if executable('look')
    call minpac#add('ujihisa/neco-look')
endif

call minpac#add('fntlnz/atags.vim')
let g:atags_build_commands_list = ['ctags -R .']
let g:atags_on_generate_stderr = 'notomo#vimrc#silent_handler'
let g:atags_on_generate_stdout = 'notomo#vimrc#silent_handler'
let g:atags_quiet = 1

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
source ~/.vim/rc/plugins/ctrlb.vim

call minpac#add('notomo/gesture.nvim', {'do' : '!npm run setup'})
nnoremap <silent> <LeftDrag> :<C-u>call gesture#draw()<CR>
nnoremap <silent> <LeftRelease> :<C-u>call gesture#finish()<CR>

if executable('python3.6') || executable('python3.7')
    call minpac#add('Shougo/defx.nvim')
    source ~/.vim/rc/plugins/defx.vim
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

call minpac#add('Shougo/deoplete.nvim')
let g:deoplete#enable_at_startup = 1
