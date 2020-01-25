setlocal completeopt-=preview
setlocal nomodeline
let b:cursorword = 0
call notomo#python#semshi_mapping()
call notomo#lsp#mapping()
