local M = {}

function M.next_no_indent_function()
  M._move("TSTextobjectGotoNextStart", "@function.outer")
end

function M.prev_no_indent_function()
  M._move("TSTextobjectGotoPreviousStart", "@function.outer")
end

function M._move(cmd, query_string)
  local origin_pos = vim.api.nvim_win_get_cursor(0)
  local view = vim.fn.winsaveview()

  local next_pos = origin_pos
  while true do
    local prev_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd(cmd .. " " .. query_string)
    local pos = vim.api.nvim_win_get_cursor(0)
    if prev_pos[1] == pos[1] then
      break
    end
    if pos[2] == 0 then
      next_pos = pos
      break
    end
  end

  vim.fn.winrestview(view)
  if next_pos == origin_pos then
    return
  end
  vim.cmd("normal! m'")
  vim.api.nvim_win_set_cursor(0, next_pos)
end

return M
