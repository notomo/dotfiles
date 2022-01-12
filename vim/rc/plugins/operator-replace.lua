vim.keymap.set({ "n", "x", "o" }, "r", [[<Plug>(operator-replace)]])
vim.keymap.set("o", "<Plug>(builtin-gn)", [[gn]])
vim.keymap.set("n", "<Plug>(builtin-/)", [[/]])
vim.keymap.set("n", "<Plug>(builtin-N)", [[N]])
vim.keymap.set("n", "[edit]n", [[*<Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)]], { remap = true })

_G._notomo_search = function()
  local tmp = vim.fn.getreg('"')
  vim.cmd([[normal! gv""y]])
  local text = vim.fn.escape(vim.fn.getreg('"'), [[\/]])
  vim.fn.setreg('"', tmp)
  return [[\V]] .. vim.fn.substitute(text, "\n", [[\\n]], "g")
end

vim.keymap.set(
  "x",
  "[edit]n",
  [["<ESC><Plug>(builtin-/)<C-r>=v:lua._notomo_search()<CR><CR><Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)"]],
  { expr = true, remap = true }
)
vim.keymap.set("x", "[edit]d ", [["<ESC>/<C-r>=v:lua._notomo_search()<CR><CR>N"_cgn"]], { expr = true })
