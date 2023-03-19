require("notomo.mapping.util").set_prefix({ "n" }, "cmdbuf", "<Space>q")

vim.keymap.set("n", "Q", [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight)<CR>]])
vim.keymap.set("n", "[cmdbuf]l", [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "lua/cmd"})<CR>]])
vim.keymap.set(
  "n",
  "[cmdbuf]/",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "vim/search/forward"})<CR>]]
)
vim.keymap.set(
  "n",
  "[cmdbuf],",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "vim/search/backward"})<CR>]]
)
vim.keymap.set(
  "n",
  "[cmdbuf]b",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "lua/variable/buffer"})<CR>]]
)
vim.keymap.set(
  "n",
  "[cmdbuf]g",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "lua/variable/global"})<CR>]]
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
  callback = function(args)
    vim.bo.bufhidden = "wipe"
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buffer = true, nowait = true })
    vim.keymap.set("n", "dd", [[<Cmd>lua require('cmdbuf').delete()<CR>]], { buffer = true })
    vim.keymap.set(
      "x",
      "D",
      [[:lua require('cmdbuf').delete({vim.api.nvim_buf_get_mark(0, "<")[1], vim.api.nvim_buf_get_mark(0, ">")[1]})<CR>]],
      { buffer = true }
    )

    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    lines = vim.tbl_filter(function(line)
      return not line:match("^Git push")
    end, lines)
    vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
  end,
})
