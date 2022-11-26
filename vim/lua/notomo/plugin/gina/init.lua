vim.fn["gina#custom#command#option"]("show", "--group", "show")
vim.g["gina#core#console#enable_message_history"] = 1

vim.api.nvim_create_augroup("gina_setting", {})

vim.g["gina#command#blame#use_default_aliases"] = 0
vim.fn["gina#custom#command#option"]([[/\%(blame\)]], "--opener", "tabedit")
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
    vim.keymap.set({ "n" }, "dd", [[:call gina#action#call("compare")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "D", [[:call gina#action#call("diff")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "o", [[:call gina#action#call("show")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "t<Space>", [[:call gina#action#call("show:tab")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "sv", [[:call gina#action#call("show:rightest")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "<CR>", [[:call gina#action#call("show:tab")<CR>]], { buffer = true, silent = true })
  end,
})

-- HACK
vim.fn["gina#component#repo#branch"]()
