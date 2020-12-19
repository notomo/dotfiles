nnoremap gw <Cmd>Reacher<CR>

autocmd MyAuGroup FileType reacher call s:reacher()
function! s:reacher() abort
    inoremap <buffer> <CR> <Cmd>Reacher finish<CR>
    inoremap <buffer> ; <Cmd>Reacher finish<CR>

    inoremap <buffer> <C-n> <Cmd>Reacher next<CR>
    inoremap <buffer> . <Cmd>Reacher next<CR>

    inoremap <buffer> <C-p> <Cmd>Reacher prev<CR>
    inoremap <buffer> , <Cmd>Reacher prev<CR>

    inoremap <buffer> <C-a> <Cmd>Reacher first<CR>
    inoremap <buffer> / <Cmd>Reacher last<CR>
    inoremap <buffer> <C-e> <Cmd>Reacher last<CR>
endfunction
