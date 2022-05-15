vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
require("notomo.lsp.mapping").setup()
require("notomo.lsp.autocmd").setup()
vim.keymap.set("n", "[finder]o", [[<Cmd>lua vim.lsp.buf.document_symbol()<CR>]], { buffer = true })
vim.keymap.set("n", "sgj", [[<Cmd>TSTextobjectGotoNextStart @function.outer<CR>]], { buffer = true })
vim.keymap.set("n", "sgk", [[<Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>]], { buffer = true })
vim.b.ale_fix_on_save = 0
