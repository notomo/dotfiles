vim.keymap.set("n", "<RightMouse>", [[<LeftMouse><Cmd>lua require("piemenu").start("lsp")<CR>]])
vim.keymap.set("x", "<RightMouse>", [[<Cmd>lua require("piemenu").start("lsp")<CR>]])

local group = vim.api.nvim_create_augroup("notomo.piemenu", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "piemenu" },
  callback = function()
    vim.o.mousemoveevent = true
    vim.keymap.set("n", "<MouseMove>", [[<Cmd>lua require("piemenu").highlight()<CR>]], { buf = 0 })
    vim.api.nvim_create_autocmd({ "BufWipeout" }, {
      buf = 0,
      once = true,
      callback = function()
        vim.o.mousemoveevent = false
      end,
    })
    vim.keymap.set("n", "<LeftDrag>", [[<Cmd>lua require("piemenu").highlight()<CR>]], { buf = 0 })
    vim.keymap.set("n", "<LeftRelease>", [[<Cmd>lua require("piemenu").finish()<CR>]], { buf = 0 })
    vim.keymap.set("n", "<RightMouse>", [[<Cmd>lua require("piemenu").cancel()<CR>]], { buf = 0 })
    vim.keymap.set("x", "<RightMouse>", [[<Cmd>lua require("piemenu").cancel()<CR>]], { buf = 0 })
    vim.keymap.set("n", "q", [[<Cmd>lua require("piemenu").cancel()<CR>]], { nowait = true, buf = 0 })
    vim.keymap.set("n", "<C-w>", [[<Cmd>lua require("piemenu").cancel()<CR>]], { nowait = true, buf = 0 })
  end,
})
