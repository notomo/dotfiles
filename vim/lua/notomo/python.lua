local M = {}

function M.indent()
  local current_line = vim.fn.getline(".")
  if (vim.fn.col(".") - 1) ~= vim.fn.matchend(current_line, "^\\s*") then
    return -1
  end
  if M._match(current_line, "\\v^\\s*[])\"'}]+$") then
    -- e.g. var = func(\n)
    return -1
  end

  local row = vim.fn.prevnonblank(vim.v.lnum - 1)
  local plus_one = vim.fn.indent(row) + vim.fn.shiftwidth()
  local line = vim.fn.getline(row)
  if M._match(line, "\\v.*\\([^)]*$") then
    -- e.g. func(
    return plus_one
  elseif M._match(line, "\\v.*:$") then
    -- e.g. def func():
    return plus_one
  elseif M._match(line, "\\v.*\\[[^]]*$") then
    -- e.g. array = [
    return plus_one
  elseif M._match(line, "\\v.*\\{[^}]*$") then
    -- e.g. dict = {
    return plus_one
  end
  return -1
end

function M._match(str, pattern)
  return vim.fn.match(str, pattern) ~= -1
end

return M
