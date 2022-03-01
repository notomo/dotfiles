vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.mk.*", "*.mk" },
  callback = function()
    vim.bo.filetype = "make"
  end,
})
