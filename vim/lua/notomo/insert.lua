local M = {}

M.delete_prev = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line():sub(col + 1)
  vim.api.nvim_buf_set_lines(0, row - 1, row, false, {line})
  vim.api.nvim_win_set_cursor(0, {row, 0})
end

M.replace_down = function()
  local start_row = vim.fn.line("'<") - 1
  local end_row = vim.fn.line("'>") - 1
  if end_row == vim.api.nvim_buf_line_count(0) - 1 then
    return
  end
  local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
  vim.api.nvim_buf_set_lines(0, start_row, end_row + 1, false, {})
  vim.api.nvim_buf_set_lines(0, start_row + 1, start_row + 1, false, lines)
  vim.fn.setpos("'<", {0, start_row + 2, 0})
  vim.fn.setpos("'>", {0, start_row + #lines + 1, 0})
end

M.replace_up = function()
  local start_row = vim.fn.line("'<") - 1
  if start_row == 0 then
    return
  end
  local end_row = vim.fn.line("'>") - 1
  local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
  vim.api.nvim_buf_set_lines(0, start_row, end_row + 1, false, {})
  vim.api.nvim_buf_set_lines(0, start_row - 1, start_row - 1, false, lines)
  vim.fn.setpos("'<", {0, end_row - #lines + 1, 0})
  vim.fn.setpos("'>", {0, end_row, 0})
end

return M
