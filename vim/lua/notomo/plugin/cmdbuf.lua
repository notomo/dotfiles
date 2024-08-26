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
  "n",
  "<Space>qg",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "lua/variable/global"})<CR>]]
)
vim.keymap.set(
  "n",
  "<Space>qi",
  [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "vim/input"})<CR>]]
)
vim.keymap.set("n", "<Space>qe", [[<Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight, {type = "vim/env"})<CR>]])

local group = vim.api.nvim_create_augroup("cmdbuf_setting", {})
vim.api.nvim_create_autocmd({ "User" }, {
  group = group,
  pattern = { "CmdbufNew" },
  callback = function(args)
    vim.bo.bufhidden = "wipe"
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buffer = true, nowait = true })

    local typ = require("cmdbuf").get_context().type
    vim.keymap.set("c", "<C-q>", function()
      require("cmdbuf").split_open(vim.o.cmdwinheight, {
        type = typ,
        line = vim.fn.getcmdline(),
        column = vim.fn.getcmdpos(),
      })
      vim.api.nvim_feedkeys(vim.keycode("<C-c>"), "n", true)
    end)

    vim.keymap.set({ "n", "i" }, "<C-q>", function()
      return require("cmdbuf").cmdline_expr()
    end, { buffer = true, expr = true })

    vim.keymap.set("n", "dd", [[<Cmd>lua require("cmdbuf").delete()<CR>]], { buffer = true })
    vim.keymap.set(
      "x",
      "D",
      [[:lua require("cmdbuf").delete({vim.api.nvim_buf_get_mark(0, "<")[1], vim.api.nvim_buf_get_mark(0, ">")[1]})<CR>]],
      { buffer = true }
    )

    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    lines = vim
      .iter(lines)
      :filter(function(line)
        return not line:match("^Git push")
      end)
      :totable()
    vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
  end,
})
