local group = vim.api.nvim_create_augroup("notomo_setting", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    pcall(vim.cmd, [[lcd `=expand('%:p:h')`]])
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    if vim.fn.bufname("%") ~= "" then
      return
    end
    local byte = vim.fn.line2byte(vim.fn.line("$") + 1)
    if byte ~= -1 or byte > 1 then
      return
    end
    vim.bo.buftype = "nofile"
    vim.bo.swapfile = false
    vim.bo.bufhidden = "wipe"
  end,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/color.lua"))
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.opt.iminsert = 0
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd({ "OptionSet" }, {
  group = group,
  pattern = { "diff" },
  callback = function()
    vim.opt_local.cursorline = false
    vim.keymap.set("n", "q", [[<Cmd>tabclose<CR>]], {
      buffer = true,
      nowait = true,
    })
  end,
})
vim.api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    if vim.opt_local.diff:get() then
      vim.opt_local.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*/roles/*.yml", "*/playbooks/*.yml" },
  callback = function()
    vim.opt_local.filetype = "yaml.ansible"
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "typescriptreact" },
  callback = function()
    vim.opt_local.filetype = "typescript.tsx"
  end,
})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "Flashy", timeout = 200, on_macro = true, on_visual = true })
  end,
})
vim.api.nvim_create_autocmd({ "UIEnter" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    if vim.g.GuiLoaded then
      require("notomo.gui").init()
    end
  end,
})

if vim.fn.has("wsl") == 1 or vim.fn.has("win32") == 1 then
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = group,
    pattern = { "*" },
    callback = function()
      require("notomo.job").run({ "zenhan.exe", "0" }, {
        on_exit = function() end,
        on_stdout = function() end,
      })
    end,
  })
end
