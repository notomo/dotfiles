nnoremap gw <Cmd>lua require("reacher").start("word")<CR>
nnoremap gs <Cmd>lua require("reacher").start("pattern")<CR>
nnoremap g; <Cmd>lua require("reacher").start("line")<CR>
nnoremap gj <Cmd>lua require("reacher").start("pattern", {first_row = vim.fn.line(".") + 1})<CR>
nnoremap gk <Cmd>lua require("reacher").start("pattern", {last_row = vim.fn.line(".") - 1})<CR>
nnoremap gl <Cmd>lua require("reacher").start("pattern", {first_row = vim.fn.line("."), last_row = vim.fn.line(".")})<CR>
nnoremap g<CR> <Cmd>lua require("reacher").start("pattern", {input = vim.fn.getreg("/")})<CR><ESC>

autocmd MyAuGroup FileType reacher call s:reacher()
function! s:reacher() abort
    inoremap <buffer> <C-n> <Cmd>lua require("reacher").next()<CR>
    inoremap <buffer> <C-p> <Cmd>lua require("reacher").prev()<CR>
    inoremap <buffer> <C-a> <Cmd>lua require("reacher").first()<CR>
    inoremap <buffer> <C-e> <Cmd>lua require("reacher").last()<CR>
    inoremap <silent> <buffer> jj <Cmd>lua require("reacher").cancel()<CR>
    inoremap <buffer> <Space> <Cmd>lua require("reacher").finish()<CR>
    inoremap <buffer> <C-Space> <Cmd>lua require("reacher").finish()<CR>
    inoremap <buffer> <CR> <ESC>
    inoremap <buffer> <Tab> <Space>

    nnoremap <silent> <buffer> q <Cmd>lua require("reacher").cancel()<CR>
    nnoremap <buffer> gg <Cmd>lua require("reacher").first()<CR>
    nnoremap <buffer> ga <Cmd>lua require("reacher").first()<CR>
    nnoremap <buffer> ge <Cmd>lua require("reacher").last()<CR>
    nnoremap <buffer> G <Cmd>lua require("reacher").last()<CR>
    nnoremap <buffer> j <Cmd>lua require("reacher").next()<CR>
    nnoremap <buffer> k <Cmd>lua require("reacher").prev()<CR>
    nnoremap <nowait> <buffer> <Space> <Cmd>lua require("reacher").finish()<CR>
    nnoremap <buffer> <CR> <Cmd>lua require("reacher").finish()<CR>
endfunction
