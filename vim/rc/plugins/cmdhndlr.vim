nnoremap <Leader>Q <Cmd>lua require("cmdhndlr").run()<CR>
xnoremap <Leader>Q <Cmd>lua require("cmdhndlr").run()<CR>

nnoremap [test]t <Cmd>lua require("cmdhndlr").run({name = 'make/make', runner_opts = {target = "test"}})<CR>
nnoremap S <Cmd>lua require("cmdhndlr").run({name = 'make/make', runner_opts = {target = "start"}})<CR>
nnoremap [exec]bl <Cmd>lua require("cmdhndlr").run({name = 'make/make', runner_opts = {target = "build"}})<CR>

nnoremap [test]f <Cmd>lua require("cmdhndlr").test()<CR>
nnoremap [test]n <Cmd>lua require("cmdhndlr").test({scope = "cursor"})<CR>
