vim.opt_local.foldmethod = "marker"
vim.b.match_words =
  [[\<if\>:\<elseif\>:\<else\>:\<endif\>,\<for\>:\<endfor\>,\<while\>:\<endwhile\>,\<try\>:\<catch\>:\<finally\>:\<endtry\>,\<func\(tion\)\?\>:\<endfunc\(tion\)\?\>,\<augroup [^E]\w*\>:\<augroup END\>]]
vim.opt_local.iskeyword:remove("#")

vim.keymap.set("n", "[exec]s", [[<Cmd>source %<CR>]], { buffer = true })
require("notomo.lsp.mapping").setup({ symbol_source = "cmd/ctags" })
