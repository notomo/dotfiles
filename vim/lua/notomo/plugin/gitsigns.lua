require("gitsigns").setup({
  current_line_blame_opts = {
    delay = 300,
  },
  current_line_blame_formatter = " <author_time:%Y-%m-%d> <author>: <summary>",
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    vim.keymap.set("x", "[git]S", ":Gitsigns stage_hunk<CR>", { buffer = bufnr })
    vim.keymap.set("x", "[git]R", ":Gitsigns reset_hunk<CR>", { buffer = bufnr })

    vim.keymap.set("n", "[git]t", gs.toggle_current_line_blame)
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  group = vim.api.nvim_create_augroup("notomo.gitsigns.refresh", {}),
  pattern = { "NotomoReloaded" },
  callback = function()
    require("gitsigns").refresh()
  end,
})
