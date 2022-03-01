vim.api.nvim_create_augroup("flompt_setting", {})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = "flompt_setting",
  pattern = { "*" },
  callback = function()
    vim.keymap.set("n", "F", [[<Cmd>lua require('flompt').open()<CR>]], { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "flompt_setting",
  pattern = { "flompt" },
  callback = function()
    vim.keymap.set("i", "<CR>", [[<Cmd>lua require('flompt').send()<CR>]], { buffer = true })
    vim.keymap.set("n", "<CR>", [[<Cmd>lua require('flompt').send()<CR>]], { buffer = true })
    vim.keymap.set("n", "q", [[<Cmd>lua require('flompt').close()<CR>]], { nowait = true, buffer = true })
    vim.keymap.set("i", "jq", [[<ESC><Cmd>lua require('flompt').close()<CR>]], { buffer = true })
  end,
})
