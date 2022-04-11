vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
require("notomo.mapping").npm()

if vim.endswith(vim.fn.bufname("%"), ".mjs") then
  vim.b.cmdhndlr = { normal_runner = "javascript/zx" }
end
