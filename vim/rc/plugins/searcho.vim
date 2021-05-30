nnoremap <expr> / searcho#do('forward') .. '\v'
nnoremap <expr> sJ searcho#do('stay_forward') .. '\v(^\|[^[:alnum:]])\zs' .. expand('<cword>') .. searcho#with_left('\ze([^[:alnum:]]\|$)')
nnoremap <expr> sK searcho#do('stay_backward') .. '\v(^\|[^[:alnum:]])\zs' .. expand('<cword>') .. searcho#with_left('\ze([^[:alnum:]]\|$)')
nnoremap <expr> sj searcho#do('stay_forward') .. expand('<cword>')
nnoremap <expr> sk searcho#do('stay_backward') .. expand('<cword>')
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
    rhs = "<CR><Cmd>lua require('reacher').start({input = vim.fn.getreg('/')})<CR><ESC>",
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
