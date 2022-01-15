vim.opt_local.completeopt:remove("preview")
vim.opt_local.modeline = false
require("notomo.mapping").lsp()

vim.keymap.set("n", "sgj", [[<Cmd>TSTextobjectGotoNextStart @function.outer<CR>]], { buffer = true })
vim.keymap.set("n", "sgk", [[<Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>]], { buffer = true })
