nnoremap <silent> [keyword]fo <Cmd>lua require("curstr").execute("openable", {action = "open"})<CR>
nnoremap <silent> [keyword]ft <Cmd>lua require("curstr").execute("openable", {action = "tab_open"})<CR>
nnoremap <silent> [keyword]fv <Cmd>lua require("curstr").execute("openable", {action = "vertical_open"})<CR>
nnoremap <silent> [keyword]fh <Cmd>lua require("curstr").execute("openable", {action = "horizontal_open"})<CR>
nnoremap <silent> [edit]s <Cmd>lua require("curstr").execute("togglable")<CR>
nnoremap <Space>rj <Cmd>lua require("curstr").execute("print", {action = "append"})<CR>j
nnoremap [edit]J <Cmd>lua require("curstr").execute("range", {action = "join"})<CR>
xnoremap [edit]J <Cmd>lua require("curstr").execute("range", {action = "join"})<CR>
