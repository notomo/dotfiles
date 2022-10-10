require("gitsigns").setup({
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
  end,
  -- attach_to_untracked = false,
  -- watch_gitdir = {
  --   enable = false,
  --   interval = 1000,
  --   follow_files = false,
  -- },
})
