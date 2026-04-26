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
    { block = { "`", "`" }, motionwise = { "char", "line", "block" }, keys = { "b" } },
    { block = { "```\n", "\n\n" .. ctrl_u .. "```" }, motionwise = { "char", "line", "block" }, keys = { "c" } },
    {
      block = { "<div>\n", "\n</div>" },
      motionwise = { "char", "line", "block" },
      keys = { "," },
    },
    {
      block = { "<details>\n<summary>Details</summary>\n\n", "\n\n\n" .. ctrl_u .. "</details>" },
      motionwise = { "char", "line", "block" },
      keys = { "s" },
    },
  },
}
