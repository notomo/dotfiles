nnoremap gw <Cmd>lua require("reacher").start({input = "\\v[^[:alnum:]]\\zs[[:alnum:]]+&.\\zs"})<CR>
nnoremap gs <Cmd>lua require("reacher").start()<CR>
nnoremap gj <Cmd>lua require("reacher").start({first_row = vim.fn.line(".") + 1})<CR>
nnoremap gk <Cmd>lua require("reacher").start({last_row = vim.fn.line(".") - 1})<CR>
nnoremap gl <Cmd>lua require("reacher").start({first_row = vim.fn.line("."), last_row = vim.fn.line(".")})<CR>
nnoremap g<CR> <Cmd>lua require("reacher").start({input = vim.fn.histget("/")})<CR><ESC>
xnoremap gs <Cmd>lua require("reacher").start()<CR>
xnoremap gl <Cmd>lua require("reacher").start({first_row = vim.fn.line("."), last_row = vim.fn.line(".")})<CR>

autocmd MyAuGroup FileType reacher call s:reacher()
function! s:reacher() abort
    inoremap <buffer> <C-n> <Cmd>lua require("reacher").next()<CR>
    inoremap <buffer> <C-p> <Cmd>lua require("reacher").previous()<CR>
    inoremap <silent> <buffer> jj <Cmd>lua require("reacher").cancel()<CR>
    inoremap <buffer> <Space> <Cmd>lua require("reacher").finish()<CR>
    inoremap <buffer> <C-Space> <Cmd>lua require("reacher").finish()<CR>
    inoremap <buffer> <C-s> <Space>
    inoremap <buffer> <CR> <ESC>
    inoremap <buffer> <Tab> .*
    inoremap <buffer> <C-j> <Cmd>lua require("reacher").forward_history()<CR>
    inoremap <buffer> <C-k> <Cmd>lua require("reacher").backward_history()<CR>

    nnoremap <nowait> <buffer> q <Cmd>lua require("reacher").cancel()<CR>
    nnoremap <buffer> ga <Cmd>lua require("reacher").first_column()<CR>
    nnoremap <buffer> ge <Cmd>lua require("reacher").last_column()<CR>
    nnoremap <nowait> <buffer> <Space> <Cmd>lua require("reacher").finish()<CR>
endfunction
