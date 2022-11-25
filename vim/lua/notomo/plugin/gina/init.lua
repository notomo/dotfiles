vim.g["gina#command#blame#use_default_aliases"] = 0
vim.g["gina#command#changes#use_default_aliases"] = 0

vim.fn["gina#custom#command#option"]("show", "--group", "show")
vim.fn["gina#custom#command#option"]("changes", "--group", "changes")
vim.fn["gina#custom#command#option"]("commit", "--group", "short")

vim.fn["gina#custom#command#option"]([[/\%(changes\|ls\|commit\)]], "--opener", "botright split")
vim.fn["gina#custom#command#option"]([[/\%(diff\|blame\|compare\|patch\)]], "--opener", "tabedit")

vim.g["gina#core#console#enable_message_history"] = 1

vim.api.nvim_create_augroup("gina_setting", {})

vim.g["gina#command#blame#formatter#format"] = "%su%=on %ti by %au %ma%in"
vim.g["gina#command#blame#formatter#timestamp_format1"] = "%Y-%m-%d"
vim.g["gina#command#blame#formatter#timestamp_format2"] = "%Y-%m-%d"
vim.g["gina#command#blame#formatter#timestamp_months"] = 0
vim.fn["gina#custom#command#option"]("blame", "--width", "90")
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-blame" },
  callback = function()
    vim.keymap.set({ "n" }, "j", "j<Plug>(gina-blame-echo)", { buffer = true })
    vim.keymap.set({ "n" }, "k", "k<Plug>(gina-blame-echo)", { buffer = true })
    vim.keymap.set({ "n" }, "<CR>", [[:call gina#action#call('show:commit:tab')<CR>]], { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "diff" },
  callback = function()
    vim.keymap.set("n", "sgj", function()
      require("notomo.edit").to_prev_syntax("diffLine", 1, 1)
    end, { buffer = true, silent = true })
    vim.keymap.set("n", "sgk", function()
      require("notomo.edit").to_prev_syntax("diffLine", 1, -1)
    end, { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-commit" },
  callback = function()
    vim.keymap.set({ "n" }, "[file]w", ":wq<CR>", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-blame" },
  callback = function()
    vim.keymap.set(
      { "n" },
      "cc",
      [[:call gina#action#call("changes:of:rightest")<CR>]],
      { buffer = true, silent = true }
    )
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-blame" },
  callback = function()
    vim.keymap.set({ "n" }, "dd", [[:call gina#action#call("compare")<CR>]], { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-blame" },
  callback = function()
    vim.keymap.set({ "n" }, "D", [[:call gina#action#call("diff")<CR>]], { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-ls", "gina-blame", "gina-changes" },
  callback = function()
    vim.keymap.set({ "n" }, "o", [[:call gina#action#call("show")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "t<Space>", [[:call gina#action#call("show:tab")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "sv", [[:call gina#action#call("show:rightest")<CR>]], { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-ls", "gina-blame", "gina-changes" },
  callback = function()
    vim.keymap.set({ "n" }, "<CR>", [[:call gina#action#call("show:tab")<CR>]], { buffer = true, silent = true })
  end,
})

-- HACK
vim.fn["gina#component#repo#branch"]()
