local group_name = "notomo_setting"
vim.api.nvim_create_augroup(group_name, {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    pcall(vim.cmd, [[lcd `=expand('%:p:h')`]])
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = group_name,
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
    vim.bo.fileformat = "unix"
  end,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    vim.api.nvim_set_hl(0, "Search", { fg = "#000000", bg = "#aaccaa" })
    vim.api.nvim_set_hl(0, "incSearch", { fg = "#fffeeb", bg = "#fb8965" })
    vim.api.nvim_set_hl(0, "Flashy", { bold = true, ctermbg = 0, fg = "#333333", bg = "#a8d2eb" })
    vim.api.nvim_set_hl(0, "ParenMatch", { underline = true, bg = "#5f8770" })
    vim.api.nvim_set_hl(0, "TabLine", { fg = "#fff5ee", bg = "#536273" })
    vim.api.nvim_set_hl(0, "YankRoundRegion", { fg = "#333333", bg = "#fedf81" })
    vim.api.nvim_set_hl(0, "ZenSpace", { underline = true, ctermbg = "DarkGreen", bg = "#ab6560" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#213243" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#213243" })

    --for gina status
    vim.api.nvim_set_hl(0, "AnsiColor1", { ctermfg = 1, fg = "#ffaaaa" })
    vim.api.nvim_set_hl(0, "AnsiColor2", { ctermfg = 2, fg = "#aaddaa" })

    vim.cmd([[highlight default link sqlStatement sqlKeyword]])
    vim.cmd([[highlight default link LspReferenceText Todo]])

    vim.api.nvim_set_hl(0, "SpellBad", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "SpellRare", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "SpellLocal", { fg = "#ff5555" })
    vim.cmd([[highlight clear SpellCap]])
    vim.cmd([[highlight default link SpellCap NONE]])

    if vim.fn.has("mac") == 1 then
      vim.api.nvim_set_hl(0, "Cursor", { bg = "#bbbbba" })
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    vim.opt.iminsert = 0
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group_name,
  pattern = { "*/roles/*.yml", "*/playbooks/*.yml" },
  callback = function()
    vim.opt_local.filetype = "yaml.ansible"
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group_name,
  pattern = { "typescriptreact" },
  callback = function()
    vim.opt_local.filetype = "typescript.tsx"
  end,
})
vim.api.nvim_create_autocmd({ "OptionSet" }, {
  group = group_name,
  pattern = { "diff" },
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    if vim.opt_local.diff:get() then
      vim.opt_local.cursorline = false
    end
  end,
})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "Flashy", timeout = 200, on_macro = true, on_visual = true })
  end,
})
vim.api.nvim_create_autocmd({ "UIEnter" }, {
  group = group_name,
  pattern = { "*" },
  callback = function()
    if vim.fn.exists("g:GuiLoaded") == 1 then
      require("notomo.gui").init()
    end
  end,
})
