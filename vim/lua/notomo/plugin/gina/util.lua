local M = {}

function M.relpath()
  local git = vim.fn["gina#core#get_or_fail"]()
  local abspath = vim.fn["gina#core#repo#abspath"](git, "")
  local curpath = vim.fn.substitute(vim.fn.expand("%:p"), "\\", "/", "g")
  return vim.fn.substitute(curpath, abspath, "", "")
end

return M
