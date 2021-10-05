set tabline=%!v:lua.require('wintablib.tab').line()

nnoremap [win]O <Cmd>lua require("wintablib.window").close_floating()<CR>
nnoremap [win]H <Cmd>lua require("wintablib.window").from_left_tab()<CR>
nnoremap [win]L <Cmd>lua require("wintablib.window").from_right_tab()<CR>
nnoremap [win]l <Cmd>lua require("wintablib.window").to_right_tab()<CR>
nnoremap [win]w <Cmd>lua require("wintablib.window").duplicate_as_right_tab()<CR>
nnoremap [win]b <Cmd>lua require("wintablib.window").from_alt()<CR>
nnoremap [win]j <Cmd>lua require("wintablib.window").close_downside()<CR>
nnoremap [win]; <Cmd>lua require("wintablib.window").close_rightside()<CR>
nnoremap [win]a <Cmd>lua require("wintablib.window").close_leftside()<CR>
nnoremap [winmv]f <Cmd>lua require("wintablib.window").focus_on_floating()<CR>
nnoremap <silent> <Plug>(tabclose_r) <Cmd>lua require("wintablib.tab").close_right()<CR>
nnoremap <silent> <Plug>(tabclose_l) <Cmd>lua require("wintablib.tab").close_left()<CR>
nnoremap <silent> <Plug>(tabclose_c) <Cmd>lua require("wintablib.tab").close()<CR>
nnoremap <silent> <Plug>(new_tab) <Cmd>lua require("wintablib.tab").scratch()<CR>
lua require("wintablib.tab").activate_left_on_closed()
