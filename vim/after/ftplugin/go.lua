vim.opt_local.completeopt:remove("preview")
vim.opt_local.expandtab = false
require("notomo.mapping").lsp()

vim.keymap.set(
  "n",
  "[yank]I",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.trim(vim.fn.system('go list -f "{{.ImportPath}}" ./')))<CR>]],
  { buffer = true }
)
vim.keymap.set("n", "sgj", [[<Cmd>lua require("notomo.text_object").next_no_indent_function()<CR>]], { buffer = true })
vim.keymap.set("n", "sgk", [[<Cmd>lua require("notomo.text_object").prev_no_indent_function()<CR>]], { buffer = true })
vim.keymap.set("n", "[exec]bL", [[<Cmd>lua require("cmdhndlr").build()<CR>]], { buffer = true })

vim.cmd([[
syntax keyword goKeywords nil iota true false
highlight link goKeywords Boolean
]])

vim.cmd([[inoreabbrev <buffer> ~= !=]])
