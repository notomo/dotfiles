vim.opt_local.modeline = false
vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
require("notomo.lsp.mapping").setup()
require("notomo.lsp.autocmd").setup()
vim.keymap.set("n", "[finder]i", [[<Cmd>lua require('thetto').start("deno/deps")<CR>]])
