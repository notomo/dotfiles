setlocal completeopt-=preview
setlocal nomodeline
let b:cursorword = 0
lua require("notomo.mapping").lsp()

nnoremap <buffer> <silent> sgj <Cmd>TSTextobjectGotoNextStart @function.outer<CR>
nnoremap <buffer> <silent> sgk <Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>
