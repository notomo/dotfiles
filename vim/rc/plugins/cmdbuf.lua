vim.keymap.set("n", "Q", [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight)<CR>]])
vim.keymap.set("n", "<Space>ql", [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "lua/cmd"})<CR>]])
vim.keymap.set(
  "n",
  "<Space>q/",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "vim/search/forward"})<CR>]]
)
vim.keymap.set(
  "n",
  "<Space>q,",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "vim/search/backward"})<CR>]]
)
vim.keymap.set(
  "n",
  "<Space>qb",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "lua/variable/buffer"})<CR>]]
)
vim.keymap.set(
  "c",
  "<C-q>",
  [[<Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {line = vim.fn.getcmdline(), column = vim.fn.getcmdpos()})<CR><C-c>]]
)

vim.api.nvim_create_augroup("cmdbuf_setting", {})
vim.api.nvim_create_autocmd({ "User" }, {
  group = "cmdbuf_setting",
  pattern = { "CmdbufNew" },
  callback = function()
    vim.bo.bufhidden = "wipe"
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buffer = true, nowait = true })
    vim.keymap.set("n", "dd", [[<Cmd>lua require('cmdbuf').delete()<CR>]], { buffer = true })
    vim.keymap.set(
      "x",
      "D",
      [[:lua require('cmdbuf').delete({vim.api.nvim_buf_get_mark(0, "<")[1], vim.api.nvim_buf_get_mark(0, ">")[1]})<CR>]],
      { buffer = true }
    )
  end,
})
