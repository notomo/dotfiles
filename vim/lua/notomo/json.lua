local M = {}

function M.next()
  M._search("")
end

function M.prev()
  M._search("b")
end

function M._search(flag)
  local indent_size = vim.fn.indent(".")
  if indent_size >= 4 then
    indent_size = 2
  end
  local pattern = [[\v^]] .. (" "):rep(indent_size) .. [[\{]]
  vim.fn.search(pattern, flag)
end

return M
