nnoremap Q <Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight)<CR>
nnoremap <Space>ql <Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "lua/cmd"})<CR>
nnoremap <Space>q/ <Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "vim/search/forward"})<CR>
nnoremap <Space>q, <Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "vim/search/backward"})<CR>
nnoremap <Space>qb <Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "lua/variable/buffer"})<CR>
cnoremap <C-q> <Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {line = vim.fn.getcmdline(), column = vim.fn.getcmdpos()})<CR><C-c>
augroup cmdbuf_setting
  autocmd!
  autocmd User CmdbufNew call s:cmdbuf()
augroup END
function! s:cmdbuf() abort
    setlocal bufhidden=wipe
    nnoremap <nowait> <buffer> q <Cmd>quit<CR>
    nnoremap <buffer> dd <Cmd>lua require('cmdbuf').delete()<CR>
    xnoremap <buffer> D :lua require('cmdbuf').delete({vim.api.nvim_buf_get_mark(0, "<")[1], vim.api.nvim_buf_get_mark(0, ">")[1]})<CR>
endfunction
