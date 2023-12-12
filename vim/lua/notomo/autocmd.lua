local group = vim.api.nvim_create_augroup("notomo_setting", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    pcall(vim.cmd.lcd, [[`=expand('%:p:h')`]])
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = group,
  pattern = { "*" },
  callback = function(args)
    local bufnr = args.buf
    if vim.api.nvim_buf_get_name(bufnr) ~= "" then
      return
    end

    local count = vim.api.nvim_buf_line_count(bufnr)
    if count > 1 then
      return
    end

    local char = vim.api.nvim_buf_get_text(bufnr, 0, 0, 0, 1, {})[1]
    if char and char ~= "" then
      return
    end

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
  end,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    package.loaded["notomo.color"] = nil
    require("notomo.color")
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.opt.iminsert = 0
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.wo.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    if not vim.wo.diff then
      vim.wo.cursorline = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "OptionSet" }, {
  group = group,
  pattern = { "diff" },
  callback = function()
    vim.wo.cursorline = false
    vim.keymap.set("n", "q", [[<Cmd>tabclose<CR>]], {
      buffer = true,
      nowait = true,
    })
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "Flashy", timeout = 200, on_macro = true, on_visual = true })
  end,
})

if vim.fn.has("gui_running") == 1 then
  vim.api.nvim_create_autocmd({ "UIEnter" }, {
    group = group,
    pattern = { "*" },
    callback = function()
      vim.cmd.Guifont({ args = { "MeiryoKe_Gothic:h14" }, bang = true })
      vim.cmd.GuiTabline("0")
      vim.cmd.GuiPopupmenu("0")
      vim.fn.GuiWindowMaximized(1)

      vim.keymap.set("n", "<Space>R", function()
        vim.fn.jobstart("nvim-qt.exe", { detach = true })
        vim.cmd.quitall()
      end)
    end,
  })
end

if vim.fn.has("wsl") == 1 or vim.fn.has("win32") == 1 then
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = group,
    pattern = { "*" },
    callback = function()
      require("notomo.lib.job").run({ "zenhan.exe", "0" }, {
        on_exit = function() end,
        on_stdout = function() end,
      })
    end,
  })
end
