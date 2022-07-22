if vim.b.current_syntax then
  return
end

vim.cmd.syntax({ args = { "match", "mytodoDone", [["^\s*#.*"]] } })
vim.api.nvim_set_hl(0, "mytodoDone", { default = true, link = "Comment" })

vim.b.current_syntax = "mytodo"
