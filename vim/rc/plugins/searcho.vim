nnoremap / <Cmd>lua require("searcho").forward("\\v")<CR>
nnoremap ? <Cmd>lua require("searcho").backward("\\v")<CR>
nnoremap sj <Cmd>lua require("searcho").forward_word()<CR>
nnoremap sJ <Cmd>lua require("searcho").forward_word({left = "\\v(^\|[^[:alnum:]])\\zs", right = "\\ze([^[:alnum:]]\|$)"})<CR>
nnoremap sk <Cmd>lua require("searcho").backward_word()<CR>
nnoremap sK <Cmd>lua require("searcho").backward_word({left = "\\v(^\|[^[:alnum:]])\\zs", right = "\\ze([^[:alnum:]]\|$)"})<CR>
nnoremap s<Space>j <Cmd>lua require("searcho").forward("\\v" .. vim.fn.getreg('"'))<CR>
nnoremap s<Space>k <Cmd>lua require("searcho").backward("\\v" .. vim.fn.getreg('"'))<CR>
nnoremap n <Cmd>lua require("searcho").next()<CR>
xnoremap n <Cmd>lua require("searcho").next()<CR>
nnoremap N <Cmd>lua require("searcho").previous()<CR>
xnoremap N <Cmd>lua require("searcho").previous()<CR>

autocmd MyAuGroup FileType searcho call s:searcho()
function! s:searcho() abort
    inoremap <silent> <buffer> jj <Cmd>lua require("searcho").cancel()<CR>
    inoremap <buffer> <Space> <Cmd>lua require("searcho").finish()<CR>
    inoremap <buffer> <CR> <Cmd>lua require("searcho").finish()<CR><Cmd>lua require('reacher').start({input = vim.fn.getreg('/')})<CR><ESC>
    inoremap <buffer> <C-Space> <Space>
    inoremap <buffer> <C-j> <Cmd>lua require("searcho").forward_history()<CR>
    inoremap <buffer> <C-k> <Cmd>lua require("searcho").backward_history()<CR>
    inoremap <buffer> <C-n> <Cmd>lua require("searcho").next_page()<CR>
    inoremap <buffer> <C-p> <Cmd>lua require("searcho").previous_page()<CR>
    inoremap <buffer> <Tab> <Cmd>lua require("searcho").next_match()<CR>
    inoremap <buffer> <S-Tab> <Cmd>lua require("searcho").previous_match()<CR>
endfunction
