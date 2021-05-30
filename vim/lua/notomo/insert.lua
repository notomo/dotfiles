local M = {}

M.delete_prev = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, col, {""})
  vim.api.nvim_win_set_cursor(0, {row, 0})
end

return M
