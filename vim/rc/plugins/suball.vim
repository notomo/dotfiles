nnoremap <expr> [substitute]aw ':%' .. luaeval('require("suball").map(_A, "")', expand('<cword>'))
nnoremap <expr> [substitute]ay ':%' .. luaeval('require("suball").map(_A, "")', @+)
