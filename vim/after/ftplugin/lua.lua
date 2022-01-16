vim.opt_local.modeline = false
vim.opt_local.completeopt:remove("preview")
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.keymap.set("n", "[exec]s", [[<Cmd>luafile %<CR>]], { buffer = true })
vim.keymap.set("n", "[exec]l", [[':lua ' . getline('.') . '<CR>']], { expr = true, buffer = true })
require("notomo.mapping").lsp()
vim.cmd([[inoreabbrev <buffer> != ~=]])
if vim.regex("_spec.lua$"):match_str(vim.fn.expand("%")) then
  vim.keymap.set(
    "n",
    "[finder]o",
    [[<Cmd>lua require("thetto").start("lua/busted", {opts = {auto = "preview"}})<CR>]],
    { buffer = true }
  )
end

vim.keymap.set("n", "sgj", [[<Cmd>lua require("notomo.text_object").next_no_indent_function()<CR>]], { buffer = true })
vim.keymap.set(
  "n",
  "sgk",
  [[sgk <Cmd>lua require("notomo.text_object").prev_no_indent_function()<CR>]],
  { buffer = true }
)
