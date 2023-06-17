require("searcho").setup_keymaps(function(vim)
  vim.keymap.set("c", "<Tab>", [[<C-g>]], { buffer = true })
  vim.keymap.set("c", "<S-Tab>", [[<C-t>]], { buffer = true })
  vim.keymap.set("c", "<Space>", [[<CR>]], { buffer = true })
  vim.keymap.set("c", "<C-Space>", [[<Space>]], { buffer = true })
  vim.keymap.set(
    "c",
    "<CR>",
    [[<CR><Cmd>lua require("reacher").start({input = vim.fn.getreg('/')})<CR><ESC>]],
    { buffer = true }
  )
end)
