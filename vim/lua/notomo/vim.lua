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

function M.indent()
  local current_line = vim.fn.getline(".")
  if (vim.fn.col(".") - 1) ~= vim.fn.matchend(current_line, "^\\s*") then
    return -1
  end

  local row = vim.fn.prevnonblank(vim.v.lnum - 1)
  local plus_one = vim.fn.indent(row) + vim.fn.shiftwidth()
  local line = vim.fn.getline(row)
  if M._match(line, "\\v.*\\(\\s*$") then
    -- e.g. func(
    return plus_one
  elseif M._match(line, "\\v^\\s*(fu|if|else|for|while)") then
    -- e.g. function!
    return plus_one
  elseif M._match(line, "\\v.*:$") then
    -- e.g. def func():
    return plus_one
  elseif M._match(line, "\\v.*\\[\\s*$") then
    -- e.g. array = [
    return plus_one
  elseif M._match(line, "\\v.*\\{\\s*$") then
    -- e.g. dict = {
    return plus_one
  end
  return -1
end

function M._match(str, pattern)
  return vim.fn.match(str, pattern) ~= -1
end

return M
