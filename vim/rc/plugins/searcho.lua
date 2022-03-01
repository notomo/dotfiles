vim.keymap.set("n", "/", [[<Cmd>lua require("searcho").forward("\\v")<CR>]])
vim.keymap.set("n", "?", [[<Cmd>lua require("searcho").backward("\\v")<CR>]])
vim.keymap.set("n", "sj", [[<Cmd>lua require("searcho").forward_word()<CR>]])
vim.keymap.set(
  "n",
  "sJ",
  [=[<Cmd>lua require("searcho").forward_word({left = "\\v(^|[^[:alnum:]])\\zs", right = "\\ze([^[:alnum:]]|$)"})<CR>]=]
)
vim.keymap.set("n", "sk", [[<Cmd>lua require("searcho").backward_word()<CR>]])
vim.keymap.set(
  "n",
  "sK",
  [=[<Cmd>lua require("searcho").backward_word({left = "\\v(^|[^[:alnum:]])\\zs", right = "\\ze([^[:alnum:]]|$)"})<CR>]=]
)
vim.keymap.set("n", "s<Space>j", [[<Cmd>lua require("searcho").forward("\\v" .. vim.fn.getreg('"'))<CR>]])
vim.keymap.set("n", "s<Space>k", [[<Cmd>lua require("searcho").backward("\\v" .. vim.fn.getreg('"'))<CR>]])
vim.keymap.set("n", "n", [[<Cmd>lua require("searcho").next()<CR>]])
vim.keymap.set("x", "n", [[<Cmd>lua require("searcho").next()<CR>]])
vim.keymap.set("n", "N", [[<Cmd>lua require("searcho").previous()<CR>]])
vim.keymap.set("x", "N", [[<Cmd>lua require("searcho").previous()<CR>]])

vim.api.nvim_create_augroup("searcho_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "searcho_setting",
  pattern = { "searcho" },
  callback = function()
    vim.keymap.set("i", "jj", [[<Cmd>lua require("searcho").cancel()<CR>]], { silent = true, buffer = true })
    vim.keymap.set("i", "<Space>", [[<Cmd>lua require("searcho").finish()<CR>]], { buffer = true })
    vim.keymap.set(
      "i",
      "<CR>",
      [[<Cmd>lua require("searcho").finish()<CR><Cmd>lua require('reacher').start({input = vim.fn.getreg('/')})<CR><ESC>]],
      { buffer = true }
    )
    vim.keymap.set("i", "<C-Space>", [[<Space>]], { buffer = true })
    vim.keymap.set("i", "<C-j>", [[<Cmd>lua require("searcho").forward_history()<CR>]], { buffer = true })
    vim.keymap.set("i", "<C-k>", [[<Cmd>lua require("searcho").backward_history()<CR>]], { buffer = true })
    vim.keymap.set("i", "<C-n>", [[<Cmd>lua require("searcho").next_page()<CR>]], { buffer = true })
    vim.keymap.set("i", "<C-p>", [[<Cmd>lua require("searcho").previous_page()<CR>]], { buffer = true })
    vim.keymap.set("i", "<Tab>", [[ <Cmd>lua require("searcho").next_match()<CR>]], { buffer = true })
    vim.keymap.set("i", "<S-Tab>", [[<Cmd>lua require("searcho").previous_match()<CR>]], { buffer = true })
  end,
})
