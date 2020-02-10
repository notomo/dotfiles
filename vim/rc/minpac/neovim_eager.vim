call minpac#add('Shougo/denite.nvim')

call minpac#add('notomo/denite-autocmd', {'depth': 0})
nnoremap <silent> [denite]a :<C-u>Denite autocmd<CR>

call minpac#add('notomo/denite-runtimepath', {'depth': 0})
nnoremap <silent> [denite]R :<C-u>Denite runtimepath<CR>

call minpac#add('notomo/denite-keymap', {'depth': 0})
nnoremap <silent> [denite]m :<C-u>Denite keymap<CR>

call minpac#add('pocari/vim-denite-emoji')
call minpac#add('junegunn/vim-emoji')
nnoremap <silent> [denite]e :<C-u>Denite emoji -default-action=append_emoji<CR>

call minpac#add('thinca/vim-themis')

call minpac#add('sheerun/vim-polyglot')
let g:polyglot_disabled = ['markdown', 'jsx', 'tsx']

autocmd MyAuGroup FileType typescriptreact set filetype=typescript.tsx

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

if executable('python3.6') || executable('python3.7')
    call minpac#add('Shougo/deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
endif

call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('lighttiger2505/deoplete-vim-lsp')

call minpac#add('Shougo/deoplete-lsp')

call minpac#add('voldikss/vim-translator')
nnoremap [keyword]T :<C-u>Translate<CR>
" HACK
xnoremap T :call translator#translate('', 'echo', v:true)<CR>
let g:translator_target_lang = 'ja'
let g:translator_default_engines = ['google']
let g:translator_history_enable = 1
