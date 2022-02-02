vim.keymap.set("n", "<Leader>Q", [[<Cmd>lua require("cmdhndlr").run()<CR>]])
vim.keymap.set("x", "<Leader>Q", [[<Cmd>lua require("cmdhndlr").run()<CR>]])

vim.keymap.set("n", "[test]t", [[<Cmd>lua require("cmdhndlr").test({name = 'make/make', layout = {type = "tab"}})<CR>]])
vim.keymap.set(
  "n",
  "S",
  [[<Cmd>lua require("cmdhndlr").run({name = 'make/make', runner_opts = {target = "start"}})<CR>]]
)
vim.keymap.set("n", "[exec]bl", [[<Cmd>lua require("cmdhndlr").build({name = 'make/make'})<CR>]])

vim.keymap.set("n", "[test]f", [[<Cmd>lua require("cmdhndlr").test()<CR>]])
vim.keymap.set("n", "[test]n", function()
  local test = require("gettest").one_node(vim.fn.line("."))
  test = test or {}
  require("cmdhndlr").test({ filter = test.name })
end)

vim.cmd([[
function! s:settings() abort
  nnoremap <buffer> [file]rl <Cmd>lua require('cmdhndlr').retry()<CR>
endfunction
augroup cmdhndlr_setting
  autocmd!
  autocmd FileType cmdhndlr call s:settings()
augroup END
]])
