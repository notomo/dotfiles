vim.keymap.set("n", "[win]H", [[<Cmd>lua require("wintablib.window").from_left_tab()<CR>]])
vim.keymap.set("n", "[win]L", [[<Cmd>lua require("wintablib.window").from_right_tab()<CR>]])
vim.keymap.set("n", "[win]l", [[<Cmd>lua require("wintablib.window").to_right_tab()<CR>]])
vim.keymap.set("n", "[win]w", [[<Cmd>lua require("wintablib.window").duplicate_as_right_tab()<CR>]])
vim.keymap.set("n", "[win]b", [[<Cmd>lua require("wintablib.window").from_alt()<CR>]])
vim.keymap.set("n", "[win]j", [[<Cmd>lua require("wintablib.window").close_downside()<CR>]])
vim.keymap.set("n", "[win];", [[<Cmd>lua require("wintablib.window").close_rightside()<CR>]])
vim.keymap.set("n", "[win]a", [[<Cmd>lua require("wintablib.window").close_leftside()<CR>]])
vim.keymap.set("n", "[winmv]f", [[<Cmd>lua require("wintablib.window").focus_on_floating()<CR>]])
vim.keymap.set("n", "<Plug>(tabclose_r)", [[<Cmd>lua require("wintablib.tab").close_right()<CR>]], { silent = true })
vim.keymap.set("n", "<Plug>(tabclose_l)", [[<Cmd>lua require("wintablib.tab").close_left()<CR>]], { silent = true })
vim.keymap.set("n", "<Plug>(tabclose_c)", [[<Cmd>lua require("wintablib.tab").close()<CR>]], { silent = true })
vim.keymap.set("n", "<Plug>(new_tab)", [[<Cmd>lua require("wintablib.tab").scratch()<CR>]], { silent = true })

vim.api.nvim_create_autocmd({ "TabNew" }, {
  group = vim.api.nvim_create_augroup("wintablib_setting", {}),
  pattern = { "*" },
  once = true,
  callback = function()
    require("wintablib.tab").activate_left_on_closed()
  end,
})
