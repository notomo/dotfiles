setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
call notomo#mapping#lsp()
nnoremap <buffer> [exec]bL <Cmd>lua require("cmdhndlr").run({name = "dart/flutter", layout = {type = "tab"}})<CR>
nnoremap <buffer> [file]L <Cmd>lua require("cmdhndlr").input("R", {name = "normal_runner/dart/flutter"})<CR>
nnoremap <buffer> [finder]o <Cmd>lua require("thetto").start("lsp_adapter/dart_outline", {opts = {auto = "preview"}})<CR>
