vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.mk.*" },
  callback = function()
    vim.bo.filetype = "make"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.mytodo" },
  callback = function()
    vim.bo.filetype = "mytodo"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "supervisord.conf" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})
