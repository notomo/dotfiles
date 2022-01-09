nmap <buffer> <Space>c <Plug>(caw:wrap:toggle:operator)_
xmap <buffer> <Space>c <Plug>(caw:wrap:toggle:operator)
setlocal tabstop=4
setlocal softtabstop=4

if exists('b:docfilter')
    nnoremap <buffer> <CR> <Cmd>lua require("docfilter").navigate({open = function(bufnr) vim.cmd([[buffer ]] .. bufnr) end})<CR>
endif
