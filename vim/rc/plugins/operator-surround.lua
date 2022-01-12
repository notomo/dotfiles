require("notomo.mapping").set_prefix({ "n", "x" }, "surround", "s")

vim.keymap.set({ "n", "x" }, "[surround]a", [[<Plug>(operator-surround-append)]], { silent = true })
vim.keymap.set(
  "n",
  "[surround]d",
  [[v<Plug>(textobj-multiblock-a)<Plug>(operator-surround-delete)]],
  { silent = true, remap = true }
)
vim.keymap.set("x", "[surround]d", [[<Plug>(operator-surround-delete)]], { silent = true })
vim.keymap.set(
  "n",
  "[surround]r",
  [[v<Plug>(textobj-multiblock-a)<Plug>(operator-surround-replace)]],
  { silent = true, remap = true }
)
vim.keymap.set("x", "[surround]r", [[<Plug>(operator-surround-replace)]], { silent = true })

vim.g["operator#surround#ignore_space"] = 0
vim.g["operator#surround#uses_input_if_no_block"] = 0

local ctrl_u = vim.api.nvim_eval('"\\<C-u>"')
vim.g["operator#surround#blocks"] = {
  ["-"] = {
    { block = { "(", ")" }, motionwise = { "char", "line", "block" }, keys = { "p" } },
    { block = { "[", "]" }, motionwise = { "char", "line", "block" }, keys = { "l" } },
    { block = { "[[", "]]" }, motionwise = { "char", "line", "block" }, keys = { "L" } },
    { block = { "{", "}" }, motionwise = { "char", "line", "block" }, keys = { "d" } },
    { block = { "<", ">" }, motionwise = { "char", "line", "block" }, keys = { "t" } },
    { block = { '"', '"' }, motionwise = { "char", "line", "block" }, keys = { "w" } },
    { block = { "'", "'" }, motionwise = { "char", "line", "block" }, keys = { "q" } },
    { block = { "%", "%" }, motionwise = { "char", "line", "block" }, keys = { "r" } },
    { block = { "|", "|" }, motionwise = { "char", "line", "block" }, keys = { "o" } },
    { block = { "*", "*" }, motionwise = { "char", "line", "block" }, keys = { "x" } },
    { block = { "**", "**" }, motionwise = { "char", "line", "block" }, keys = { "X" } },
    { block = { "`", "`" }, motionwise = { "char", "line", "block" }, keys = { "b" } },
    { block = { "~~", "~~" }, motionwise = { "char", "line", "block" }, keys = { "T" } },
    { block = { "【", "】" }, motionwise = { "char", "line", "block" }, keys = { "D" } },
    { block = { "「", "」" }, motionwise = { "char", "line", "block" }, keys = { ";" } },
    { block = { "（", "）" }, motionwise = { "char", "line", "block" }, keys = { "P" } },
    { block = { "```\n", "\n\n" .. ctrl_u .. "```" }, motionwise = { "char", "line", "block" }, keys = { "c" } },
    {
      block = { "<pre>\n", "\n\n" .. ctrl_u .. "</pre>" },
      motionwise = { "char", "line", "block" },
      keys = { "apre" },
    },
    {
      block = { "<details>\n<summary>Details</summary>\n\n", "\n\n\n" .. ctrl_u .. "</details>" },
      motionwise = { "char", "line", "block" },
      keys = { "s" },
    },
  },
}
