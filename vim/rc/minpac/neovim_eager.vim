call minpac#add('Shougo/denite.nvim')

call minpac#add('notomo/denite-autocmd', {'depth': 0})
nnoremap <silent> [denite]a :<C-u>Denite autocmd<CR>

call minpac#add('notomo/denite-runtimepath', {'depth': 0})
nnoremap <silent> [denite]R :<C-u>Denite runtimepath<CR>

call minpac#add('notomo/denite-keymap', {'depth': 0})
nnoremap <silent> [denite]m :<C-u>Denite keymap:n<CR>

call minpac#add('pocari/vim-denite-emoji')
call minpac#add('junegunn/vim-emoji')
nnoremap <silent> [denite]e :<C-u>Denite emoji -default-action=append_emoji<CR>

call minpac#add('vim-jp/vimdoc-ja')

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

if executable('node')
    call minpac#add('notomo/ctrlb.nvim', {'do' : '!npm run setup', 'depth': 0})
    nnoremap <expr> [exec]cb ":\<C-u>CtrlbOpenLayout ~/dotfiles/vim/rc/plugins/ctrlb_layout.json\<CR>"
    nnoremap [exec]c<CR> :<C-u>CtrlbClearAll<CR>
    nnoremap [exec]cc :<C-u>CtrlbOpen ctrl<CR>
endif

if executable('python3.6') || executable('python3.7')
    call minpac#add('Shougo/defx.nvim')

    call minpac#add('Shougo/deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
endif

call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('lighttiger2505/deoplete-vim-lsp')
