vim.keymap.set({ "n", "x" }, "J", [[<Cmd>lua require("notomo.json").next()<CR>]], { buffer = true })
vim.keymap.set({ "n", "x" }, "K", [[<Cmd>lua require("notomo.json").prev()<CR>]], { buffer = true })
if vim.fn.bufname("%") == "package.json" then
  require("notomo.npm").mapping()
end
require("notomo.lsp.autocmd").setup()
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
