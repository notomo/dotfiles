vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "go.mod" },
  callback = function()
    vim.bo.filetype = "gomod"
  end,
})
