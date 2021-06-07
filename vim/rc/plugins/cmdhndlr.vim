nnoremap <Leader>Q <Cmd>lua require("cmdhndlr").run()<CR>
xnoremap <Leader>Q <Cmd>lua require("cmdhndlr").run()<CR>

nnoremap [test]t <Cmd>lua require("cmdhndlr").test({name = 'make/make', layout = {type = "tab"}})<CR>
nnoremap S <Cmd>lua require("cmdhndlr").run({name = 'make/make', runner_opts = {target = "start"}})<CR>
nnoremap [exec]bl <Cmd>lua require("cmdhndlr").build({name = 'make/make'})<CR>

nnoremap [test]f <Cmd>lua require("cmdhndlr").test()<CR>
nnoremap [test]n <Cmd>lua require("cmdhndlr").test({scope = "cursor"})<CR>
