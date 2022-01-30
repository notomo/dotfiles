vim.opt_local.completeopt:remove("preview")
vim.opt_local.expandtab = false
require("notomo.mapping").lsp()

vim.keymap.set(
  "n",
  "[yank]I",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.trim(vim.fn.system('go list -f "{{.ImportPath}}" ./')))<CR>]],
  { buffer = true }
)
vim.keymap.set("n", "sgj", [[<Cmd>lua require("notomo.text_object").next_no_indent_function()<CR>]], { buffer = true })
vim.keymap.set("n", "sgk", [[<Cmd>lua require("notomo.text_object").prev_no_indent_function()<CR>]], { buffer = true })
vim.keymap.set("n", "[exec]bL", [[<Cmd>lua require("cmdhndlr").build()<CR>]], { buffer = true })

if vim.regex("_test.go$"):match_str(vim.fn.expand("%")) then
  vim.keymap.set(
    "n",
    "[finder]o",
    [[<Cmd>lua require("thetto").start("test", {opts = {auto = "preview"}})<CR>]],
    { buffer = true }
  )
end

local test_pattern = [[\v^(func Test|\s*t\.Run)]]
vim.keymap.set("n", "sgn", function()
  require("notomo.edit").jump(test_pattern, "W")
end, { buffer = true })
vim.keymap.set("n", "sgp", function()
  require("notomo.edit").jump(test_pattern, "Wb")
end, { buffer = true })

vim.cmd([[
syntax keyword goKeywords nil iota true false
highlight link goKeywords Boolean
]])

vim.cmd([[inoreabbrev <buffer> ~= !=]])

require("notomo.treesitter").text_object_mapping()
