require("gitsigns").setup({})

vim.api.nvim_create_autocmd({ "User" }, {
  group = vim.api.nvim_create_augroup("notomo.gitsigns.refresh", {}),
  pattern = { "NotomoReloaded" },
  callback = function()
    require("gitsigns").refresh()
  end,
})
