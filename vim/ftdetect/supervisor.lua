vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "supervisord.conf" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})
