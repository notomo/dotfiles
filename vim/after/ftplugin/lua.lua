vim.opt_local.modeline = false
vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.keymap.set("n", "[exec]s", [[<Cmd>luafile %<CR>]], { buffer = true })
vim.keymap.set("n", "[exec]l", [[':lua ' . getline('.') . '<CR>']], { expr = true, buffer = true })
require("notomo.mapping").lsp()
vim.cmd([[inoreabbrev <buffer> != ~=]])

vim.keymap.set("n", "sgj", [[<Cmd>lua require("notomo.text_object").next_no_indent_function()<CR>]], { buffer = true })
vim.keymap.set("n", "sgk", [[<Cmd>lua require("notomo.text_object").prev_no_indent_function()<CR>]], { buffer = true })

require("notomo.treesitter").text_object_mapping()
