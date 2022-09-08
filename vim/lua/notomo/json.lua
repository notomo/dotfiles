local M = {}

function M.next()
  vim.cmd.normal({ args = { "%" }, bang = true })

  local line = vim.trim(vim.fn.getline("."))
  if line == "}," then
    return vim.cmd.normal({ args = { "j" }, bang = true })
  end

  vim.cmd.normal({ args = { "j^%j$" }, bang = true })
end

function M.prev()
  vim.cmd.normal({ args = { "k" }, bang = true })

  local line = vim.trim(vim.fn.getline("."))
  if line == "}," then
    return vim.cmd.normal({ args = { "%" }, bang = true })
  end

  vim.cmd.normal({ args = { "$%k$%" }, bang = true })
end

return M
