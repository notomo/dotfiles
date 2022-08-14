local M = {}

function M.next()
  M._move(true)
end

function M.prev()
  M._move(false)
end

function M._move(to_next)
  local flags
  if to_next then
    flags = ""
  else
    flags = "b"
  end
  vim.fn.search("\\v^\\s*\\zsfu(nction)?(!)?", flags)
end

return M
