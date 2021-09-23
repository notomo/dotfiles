setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
lua require("notomo.mapping").lsp()
nnoremap <buffer> [exec]bL <Cmd>lua require("cmdhndlr").run({name = "dart/flutter", layout = {type = "tab"}})<CR>
nnoremap <buffer> [file]L <Cmd>lua require("cmdhndlr").input("R", {name = "normal_runner/dart/flutter"})<CR>
nnoremap <buffer> [file]O <Cmd>lua require("thetto").start("cmdhndlr/executed", {opts = {action = "tab_drop", immediately = true, input = "flutter"}, source_opts = {is_running = true}})<CR>
nnoremap <buffer> [finder]o <Cmd>lua require("thetto").start("lsp_adapter/dart_outline", {opts = {auto = "preview"}})<CR>

augroup flutter_hot_reload
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> lua require("cmdhndlr").input("r", {name = "normal_runner/dart/flutter"})
augroup END

nnoremap <buffer> <silent> sgj <Cmd>TSTextobjectGotoNextStart @function.outer<CR>
nnoremap <buffer> <silent> sgk <Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>
