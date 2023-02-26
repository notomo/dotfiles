vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
require("notomo.npm").mapping()
require("notomo.lsp.mapping").setup()
require("notomo.lsp.autocmd").setup()

if vim.endswith(vim.fn.bufname(), ".mjs") then
  vim.b.cmdhndlr = { normal_runner = "javascript/zx" }
end
