vim.opt_local.modeline = false
vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
require("notomo.lsp.mapping").setup()
require("notomo.lsp.autocmd").setup()
vim.keymap.set(
  "n",
  "[exec]bL",
  [[<Cmd>lua require("cmdhndlr").run({name = "dart/flutter", layout = {type = "tab"}})<CR>]],
  { buffer = true }
)
vim.keymap.set(
  "n",
  "[file]L",
  [[<Cmd>lua require("cmdhndlr").input("R", {name = "normal_runner/dart/flutter"})<CR>]],
  { buffer = true }
)
vim.keymap.set(
  "n",
  "[file]O",
  [[<Cmd>lua require("thetto").start("cmdhndlr/executed", {opts = {action = "tab_drop", immediately = true, input = "flutter"}, source_opts = {is_running = true}})<CR>]],
  { buffer = true }
)
vim.keymap.set(
  "n",
  "[finder]o",
  [[<Cmd>lua require("thetto").start("lsp_adapter/dart_outline")<CR>]],
  { buffer = true }
)

vim.api.nvim_create_augroup("flutter_hot_reload", {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = "flutter_hot_reload",
  buffer = 0,
  callback = function()
    require("cmdhndlr").input("r", { name = "normal_runner/dart/flutter" })
  end,
})

vim.keymap.set("n", "sgj", [[<Cmd>TSTextobjectGotoNextStart @function.outer<CR>]], { buffer = true })
vim.keymap.set("n", "sgk", [[<Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>]], { buffer = true })
