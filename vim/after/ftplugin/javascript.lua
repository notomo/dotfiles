vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
require("notomo.mapping").npm()

if vim.endswith(vim.fn.bufname("%"), ".mjs") then
  vim.keymap.set("n", "<Leader>Q", function()
    require("cmdhndlr").run({ name = "javascript/zx" })
  end, { buffer = true })
end
