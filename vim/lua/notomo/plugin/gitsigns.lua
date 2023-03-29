require("gitsigns").setup({
  current_line_blame_opts = {
    delay = 300,
  },
  current_line_blame_formatter = " <author_time:%Y-%m-%d> <author>: <summary>",
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    vim.keymap.set("n", "[git]j", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, buffer = bufnr })

    vim.keymap.set("n", "[git]k", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, buffer = bufnr })

    vim.keymap.set("x", "[git]S", ":Gitsigns stage_hunk<CR>", { buffer = bufnr })
    vim.keymap.set("x", "[git]R", ":Gitsigns reset_hunk<CR>", { buffer = bufnr })

    vim.keymap.set("n", "[git]t", gs.toggle_current_line_blame)
  end,
})
