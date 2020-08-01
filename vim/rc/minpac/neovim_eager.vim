call minpac#add('junegunn/vim-emoji')

call minpac#add('thinca/vim-themis')
call minpac#add('notomo/vusted')

call minpac#add('sheerun/vim-polyglot')
let g:polyglot_disabled = ['markdown', 'jsx', 'tsx', 'ansible']

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

if executable('python3')
    call minpac#add('Shougo/deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
endif

call minpac#add('ncm2/float-preview.nvim')
let g:float_preview#docked = 0

call minpac#add('neovim/nvim-lsp')
call minpac#add('Shougo/deoplete-lsp')

call minpac#add('voldikss/vim-translator')
nnoremap [keyword]T :<C-u>Translate<CR>
xmap T <Plug>TranslateV
let g:translator_target_lang = 'ja'
let g:translator_default_engines = ['google']
let g:translator_history_enable = 1

call minpac#add('notomo/suball.vim', {'depth': 0})
nnoremap <expr> [substitute]aw ':%' . suball#input(expand('<cword>'), "")
nnoremap <expr> [substitute]ay ':%' . suball#input(@+, "")

call minpac#add('notomo/searcho.nvim', {'depth': 0})
nnoremap <expr> / searcho#do('forward') .. '\v'
nnoremap <expr> sj searcho#do('stay_forward') .. '\v' .. expand('<cword>')
nnoremap <expr> sk searcho#do('stay_backward') .. '\v' .. expand('<cword>')
nnoremap <expr> s<Space>j searcho#do('forward') .. '\v' .. @"
nnoremap <expr> s<Space>k searcho#do('backward') .. '\v' .. @"
nnoremap <expr> n searcho#do('next')
nnoremap <expr> N searcho#do('prev')
autocmd MyAuGroup User SearchoSourceLoad call s:searcho_settings()
function! s:searcho_settings() abort
    lua << EOF
local keymaps = require('searcho/search').keymaps
table.insert(keymaps, {
    lhs = "<Space>",
    rhs = "<CR>",
    noremap = true,
})
table.insert(keymaps, {
    lhs = "<CR>",
    rhs = "<CR><Cmd>Hita search<CR>",
    noremap = true,
})
table.insert(keymaps, {
    lhs = "<Tab>",
    rhs = "<C-g>",
    noremap = true,
})
table.insert(keymaps, {
    lhs = "<S-Tab>",
    rhs = "<C-t>",
    noremap = true,
})
table.insert(keymaps, {
    lhs = "<C-Space>",
    rhs = "<Space>",
    noremap = true,
})
EOF
endfunction
