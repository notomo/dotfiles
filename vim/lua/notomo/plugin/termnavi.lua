vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = vim.api.nvim_create_augroup("notomo.termnavi", {}),
  pattern = { "*" },
  callback = function()
    local enter = function()
      local ok, err = pcall(function()
        require("notomo.lib.edit").set_term_title()
        require("termnavi").mark({
          prompt_pattern = [=[\v^\[.*\]$\_.^\$]=],
          extmark_opts = {
            hl_eol = true,
            hl_group = "TermnaviLine",
            number_hl_group = "TermnaviLine",
          },
        })
      end)
      if not ok then
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.notify(err, vim.log.levels.WARN)
      end
      return "<CR>"
    end
    vim.keymap.set("t", "<CR>", enter, { expr = true, buffer = true })
    vim.keymap.set("t", "<C-CR>", enter, { expr = true, buffer = true })
    vim.keymap.set("t", "<S-CR>", enter, { expr = true, buffer = true })

    vim.keymap.set("t", "<C-l>", function()
      require("termnavi").clear()
      return "<C-l>"
    end, { expr = true, buffer = true })

    vim.keymap.set("n", "[finder]o", function()
      require("thetto.util.source").start_by_name("termnavi")
    end, { buffer = true })

    vim.keymap.set({ "n", "x" }, "sgj", [[<Cmd>lua require("termnavi").next()<CR>]], { buffer = true })
    vim.keymap.set("o", "gj", [[<Cmd>lua require("termnavi").next()<CR>]], { buffer = true })
    vim.keymap.set({ "n", "x" }, "sgk", [[<Cmd>lua require("termnavi").previous()<CR>]], { buffer = true })
    vim.keymap.set("o", "gk", [[<Cmd>lua require("termnavi").previous()<CR>]], { buffer = true })
  end,
})
