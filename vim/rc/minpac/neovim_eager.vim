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
