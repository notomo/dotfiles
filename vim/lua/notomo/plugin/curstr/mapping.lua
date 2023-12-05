vim.keymap.set(
  "n",
  "[keyword]fo",
  [[<Cmd>lua require("curstr").execute("openable", {action = "open"})<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[keyword]ft",
  [[<Cmd>lua require("curstr").execute("openable", {action = "tab_open"})<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[keyword]fv",
  [[<Cmd>lua require("curstr").execute("openable", {action = "vertical_open"})<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[keyword]fh",
  [[<Cmd>lua require("curstr").execute("openable", {action = "horizontal_open"})<CR>]],
  { silent = true }
)
vim.keymap.set("n", "[edit]s", [[<Cmd>lua require("curstr").execute("togglable")<CR>]], { silent = true })
vim.keymap.set("n", "[edit]k", [[<Cmd>lua require("curstr").execute("snake_kebab")<CR>]], { silent = true })
vim.keymap.set("n", "<Space>rj", [[<Cmd>lua require("curstr").execute("print", {action = "append"})<CR>j]])
vim.keymap.set("n", "[edit]J", [[<Cmd>lua require("curstr").execute("range", {action = "join"})<CR>]])
vim.keymap.set("x", "[edit]J", [[<Cmd>lua require("curstr").execute("range", {action = "join"})<CR>]])
