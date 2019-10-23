
autocmd MyAuGroup FileType valtair call s:settings()
function! s:settings() abort
    nnoremap <buffer> ga <Cmd>ValtairDo first<CR>
    nnoremap <buffer> ge <Cmd>ValtairDo last<CR>
    nnoremap <buffer> w <Cmd>ValtairDo next<CR>
    nnoremap <buffer> b <Cmd>ValtairDo prev<CR>
    nnoremap <buffer> j <Cmd>ValtairDo down<CR>
    nnoremap <buffer> k <Cmd>ValtairDo up<CR>
    nnoremap <buffer> h <Cmd>ValtairDo left<CR>
    nnoremap <buffer> l <Cmd>ValtairDo right<CR>
    nnoremap <buffer> q <Cmd>ValtairDo quit<CR>
    nnoremap <buffer> <CR> <Cmd>ValtairDo open<CR>
endfunction

nnoremap F <Cmd>Valtair<CR>
