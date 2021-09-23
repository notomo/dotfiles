if vim.b.current_syntax then
  return
end

vim.cmd([[
syntax match mytodoDone "^\s*#.*"
highlight default link mytodoDone Comment
]])

vim.b.current_syntax = "mytodo"
