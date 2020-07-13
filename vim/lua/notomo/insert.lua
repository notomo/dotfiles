local M = {}

M.delete_prev = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line():sub(col + 1)
  vim.api.nvim_buf_set_lines(0, row - 1, row, false, {line})
  vim.api.nvim_win_set_cursor(0, {row, 0})
end

return M
