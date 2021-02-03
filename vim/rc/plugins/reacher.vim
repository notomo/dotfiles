packadd reacher.nvim
nnoremap gw <Cmd>lua require("reacher").start()<CR>

autocmd MyAuGroup FileType reacher call s:reacher()
function! s:reacher() abort
    inoremap <buffer> <C-n> <Cmd>lua require("reacher").next()<CR>
    inoremap <buffer> <C-p> <Cmd>lua require("reacher").prev()<CR>
    inoremap <buffer> <C-a> <Cmd>lua require("reacher").first()<CR>
    inoremap <buffer> <C-e> <Cmd>lua require("reacher").last()<CR>
    inoremap <buffer> <CR> <Cmd>lua require("reacher").finish()<CR>
    inoremap <silent> <buffer> jj <Cmd>lua require("reacher").cancel()<CR>
    inoremap <buffer> <Space> <Cmd>lua require("reacher").finish()<CR>
    inoremap <buffer> <CR> <ESC>

    nnoremap <silent> <buffer> q <Cmd>lua require("reacher").cancel()<CR>
    nnoremap <buffer> ga <Cmd>lua require("reacher").first()<CR>
    nnoremap <buffer> ge <Cmd>lua require("reacher").last()<CR>
    nnoremap <buffer> j <Cmd>lua require("reacher").next()<CR>
    nnoremap <buffer> k <Cmd>lua require("reacher").prev()<CR>
    nnoremap <nowait> <buffer> <Space> <Cmd>lua require("reacher").finish()<CR>
    nnoremap <buffer> <CR> <Cmd>lua require("reacher").finish()<CR>
endfunction
