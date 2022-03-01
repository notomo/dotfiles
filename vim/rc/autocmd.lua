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
    vim.cmd([[highlight Search cterm=NONE guifg=#000000 guibg=#aaccaa]])
    vim.cmd([[highlight incSearch cterm=NONE guifg=#fffeeb guibg=#fb8965]])
    vim.cmd([[highlight Flashy term=bold ctermbg=0 guifg=#333333 guibg=#a8d2eb]])
    vim.cmd([[highlight ParenMatch term=underline cterm=underline guibg=#5f8770]])
    vim.cmd([[highlight TabLine guifg=#fff5ee guibg=#536273 gui=none]])
    vim.cmd([[highlight YankRoundRegion guifg=#333333 guibg=#fedf81]])
    vim.cmd([[highlight def link sqlStatement sqlKeyword]])
    vim.cmd([[highlight ZenSpace term=underline ctermbg=DarkGreen guibg=#ab6560]])
    vim.cmd([[highlight NormalFloat guibg=#213243]])

    --for gina status
    vim.cmd([[highlight AnsiColor1 ctermfg=1 guifg=#ffaaaa]])
    vim.cmd([[highlight AnsiColor2 ctermfg=2 guifg=#aaddaa]])

    vim.cmd([[highlight clear SpellCap]])
    vim.cmd([[highlight def link SpellCap NONE]])
    vim.cmd([[highlight clear SpellBad]])
    vim.cmd([[highlight SpellBad guifg=#ff5555]])
    vim.cmd([[highlight clear SpellRare]])
    vim.cmd([[highlight SpellRare guifg=#ff5555]])
    vim.cmd([[highlight clear SpellLocal]])
    vim.cmd([[highlight SpellLocal guifg=#ff5555]])

    if vim.fn.has("mac") == 1 then
      vim.cmd([[highlight Cursor guibg=#bbbbba]])
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
