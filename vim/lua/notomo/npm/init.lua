local M = {}

function M.mapping()
  vim.keymap.set(
    "n",
    "[exec]bl",
    [[<Cmd>lua require("cmdhndlr").build({name = 'javascript/npm'})<CR>]],
    { buffer = true }
  )
  vim.keymap.set(
    "n",
    "[test]t",
    [[<Cmd>lua require("cmdhndlr").test({name = 'javascript/npm', layout = {type = "tab"}})<CR>]],
    { buffer = true }
  )
  vim.keymap.set(
    "n",
    "[exec],",
    [[<Cmd>lua require("thetto").start("cmd/npm/script", {opts = {sorters = {"alphabet"}, target = "upward", target_patterns = {"package.json"}, insert = false}})<CR>]],
    { buffer = true }
  )
end

return M
