vim.keymap.set("n", "<Leader>Q", [[<Cmd>lua require("cmdhndlr").run()<CR>]])
vim.keymap.set("x", "<Leader>Q", [[<Cmd>lua require("cmdhndlr").run()<CR>]])

vim.keymap.set("n", "[test]t", [[<Cmd>lua require("cmdhndlr").test({name = 'make/make', layout = {type = "tab"}})<CR>]])
vim.keymap.set(
  "n",
  "S",
  [[<Cmd>lua require("cmdhndlr").run({name = 'make/make', runner_opts = {target = "start"}})<CR>]]
)
vim.keymap.set("n", "[exec]bl", [[<Cmd>lua require("cmdhndlr").build({name = 'make/make'})<CR>]])
vim.keymap.set("n", "[exec]bL", [[<Cmd>lua require("cmdhndlr").build()<CR>]])

vim.keymap.set("n", "[test]f", [[<Cmd>lua require("cmdhndlr").test({layout = {type = "tab"}})<CR>]])
vim.keymap.set("n", "[test]n", function()
  local test = require("gettest").one_node(vim.fn.line("."))
  test = test or {}
  require("cmdhndlr").test({ filter = test.name, is_leaf = test.is_leaf })
end)
vim.keymap.set("n", "[test]N", function()
  local test = require("gettest").scope_root_node(vim.fn.line("."))
  test = test or {}
  require("cmdhndlr").test({ filter = test.name, is_leaf = test.is_leaf })
end)

vim.api.nvim_create_augroup("cmdhndlr_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "cmdhndlr_setting",
  pattern = { "cmdhndlr" },
  callback = function()
    vim.keymap.set("n", "[file]rl", [[<Cmd>lua require('cmdhndlr').retry()<CR>]], { buffer = true })
  end,
})
