
nnoremap [exec]F :<C-u>Kiview<CR>

autocmd MyAuGroup FileType kiview call s:settings()
function! s:settings() abort
    nnoremap <buffer> l <Cmd>Kiview child<CR>
    nnoremap <buffer> h <Cmd>Kiview parent<CR>
    nnoremap <buffer> o <Cmd>Kiview toggle_tree<CR>
    nnoremap <buffer> <expr> <Space>h ":<C-u>Kiview go -path=" . $HOME  . "\<CR>"
    nnoremap <buffer> <expr> <Space>g ":<C-u>Kiview go -path=" . fnamemodify(notomo#vimrc#search_parent_recursive('.git', getcwd()), ':h:h') . "\<CR>"
    nnoremap <buffer> <2-LeftMouse> <Cmd>Kiview child<CR>

    nnoremap <buffer> sm <Cmd>Kiview toggle_selection<CR>
    xnoremap <buffer> sm :Kiview toggle_selection<CR>

    nnoremap <buffer> q <Cmd>Kiview quit<CR>

    nnoremap <buffer> i <Cmd>Kiview new<CR>
    nnoremap <buffer> df <Cmd>Kiview remove<CR>
    nnoremap <buffer> yf <Cmd>Kiview copy<CR>
    nnoremap <buffer> xf <Cmd>Kiview cut<CR>
    nnoremap <buffer> p <Cmd>Kiview paste<CR>
    nnoremap <buffer> rn <Cmd>Kiview rename<CR>

    nnoremap <buffer> t<Space> <Cmd>Kiview child -layout=tab -quit<CR>
    nnoremap <buffer> sv <Cmd>Kiview child -layout=vertical -quit<CR>
    nnoremap <buffer> sh <Cmd>Kiview child -layout=horizontal -quit<CR>

    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
endfunction
