vim.opt_local.modeline = false
vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
require("notomo.mapping").lsp()
require("notomo.mapping").npm()
