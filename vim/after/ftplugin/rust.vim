setlocal completeopt-=preview
setlocal nomodeline
lua require("notomo.mapping").lsp()

nnoremap <buffer> <silent> sgj <Cmd>TSTextobjectGotoNextStart @function.outer<CR>
nnoremap <buffer> <silent> sgk <Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>
