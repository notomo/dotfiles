nnoremap <RightMouse> <LeftMouse><Cmd>lua require("piemenu").start("lsp")<CR>
xnoremap <RightMouse> <Cmd>lua require("piemenu").start("lsp")<CR>

autocmd MyAuGroup FileType piemenu call s:piemenu()
function! s:piemenu() abort
    nnoremap <buffer> <LeftDrag> <Cmd>lua require("piemenu").highlight()<CR>
    nnoremap <buffer> <LeftRelease> <Cmd>lua require("piemenu").finish()<CR>
    nnoremap <buffer> <RightMouse> <Cmd>lua require("piemenu").cancel()<CR>
    xnoremap <buffer> <RightMouse> <Cmd>lua require("piemenu").cancel()<CR>
    nnoremap <nowait> <buffer> q <Cmd>lua require("piemenu").cancel()<CR>
    nnoremap <buffer> <C-w> <Cmd>lua require("piemenu").cancel()<CR>
endfunction
