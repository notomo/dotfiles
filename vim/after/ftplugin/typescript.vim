setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
lua require("notomo.mapping").lsp()
lua require("notomo.mapping").npm()
