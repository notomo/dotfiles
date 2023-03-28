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
  local test = require("gettest").nodes({
    scope = "smallest_ancestor",
    target = { row = vim.fn.line(".") },
  })[1]
  test = test or { children = {} }
  require("cmdhndlr").test({ filter = test.full_name, is_leaf = #test.children == 0 })
end)
vim.keymap.set("n", "[test]N", function()
  local test = require("gettest").nodes({
    scope = "largest_ancestor",
    target = { row = vim.fn.line(".") },
  })[1]
  test = test or { children = {} }
  require("cmdhndlr").test({ filter = test.full_name, is_leaf = #test.children == 0 })
end)
vim.keymap.set("x", "[test]N", function()
  local selected_text = require("notomo.lib.edit").get_selected_text()

  local tests, info = require("gettest").nodes({
    scope = "smallest_ancestor",
    target = { row = vim.fn.line(".") },
  })
  local test = tests[1]
  test = test or { children = {} }

  require("cmdhndlr").test({ filter = test.full_name .. info.tool.separator .. selected_text })
end)
vim.keymap.set("n", "[test]d", function()
  local test = require("gettest").nodes({
    scope = "smallest_ancestor",
    target = { row = vim.fn.line(".") },
  })[1]
  if not test then
    require("misclib.message").warn("not found test")
    return nil
  end

  require("dap").run({
    type = "go",
    name = test.full_name,
    request = "launch",
    mode = "test",
    program = "${relativeFileDirname}",
    args = { "-test.run", test.full_name },
  })
end)

vim.api.nvim_create_augroup("cmdhndlr_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "cmdhndlr_setting",
  pattern = { "cmdhndlr" },
  callback = function()
    vim.keymap.set("n", "[file]rl", [[<Cmd>lua require("cmdhndlr").retry()<CR>]], { buffer = true })
  end,
})
