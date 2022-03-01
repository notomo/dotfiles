vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.mytodo" },
  callback = function()
    vim.bo.filetype = "mytodo"
  end,
})
