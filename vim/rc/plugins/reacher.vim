nnoremap gw <Cmd>Reacher<CR>

autocmd MyAuGroup FileType reacher call s:reacher()
function! s:reacher() abort
    inoremap <buffer> <C-n> <Cmd>Reacher next<CR>
    inoremap <buffer> <C-p> <Cmd>Reacher prev<CR>
    inoremap <buffer> <C-a> <Cmd>Reacher first<CR>
    inoremap <buffer> <C-e> <Cmd>Reacher last<CR>
    inoremap <buffer> <CR> <Cmd>Reacher finish<CR>
    inoremap <silent> <buffer> jj <Cmd>wincmd w<CR>
    inoremap <buffer> <Space> <Cmd>Reacher finish<CR>
    inoremap <buffer> <CR> <ESC>

    nnoremap <silent> <buffer> q <Cmd>wincmd w<CR>
    nnoremap <buffer> ga <Cmd>Reacher first<CR>
    nnoremap <buffer> ge <Cmd>Reacher last<CR>
    nnoremap <buffer> j <Cmd>Reacher next<CR>
    nnoremap <buffer> k <Cmd>Reacher prev<CR>
    nnoremap <nowait> <buffer> <Space> <Cmd>Reacher finish<CR>
    nnoremap <buffer> <CR> <Cmd>Reacher finish<CR>
endfunction
