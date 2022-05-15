vim.opt_local.modeline = false
vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.keymap.set("n", "[exec]s", [[<Cmd>luafile %<CR>]], { buffer = true })
vim.keymap.set("n", "[exec]l", [[':lua ' . getline('.') . '<CR>']], { expr = true, buffer = true })
vim.keymap.set(
  "n",
  "[yank]I",
  [[<Cmd>lua require("notomo.edit").yank(require("notomo.module").path())<CR>]],
  { buffer = true }
)
require("notomo.lsp.mapping").setup()
require("notomo.lsp.autocmd").setup()
vim.cmd([[inoreabbrev <buffer> != ~=]])

vim.keymap.set(
  "n",
  "sgj",
  [[<Cmd>lua require("notomo.plugin.treesitter").next_no_indent_function()<CR>]],
  { buffer = true }
)
vim.keymap.set(
  "n",
  "sgk",
  [[<Cmd>lua require("notomo.plugin.treesitter").prev_no_indent_function()<CR>]],
  { buffer = true }
)

require("notomo.plugin.treesitter").text_object_mapping()
