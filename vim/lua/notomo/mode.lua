local M = {}

local CTRL_V = vim.api.nvim_eval('"\\<C-v>"')
local ESC = vim.api.nvim_eval('"\\<ESC>"')
function M.leave_visual_mode()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "v" or mode == "V" or mode == CTRL_V then
    vim.cmd("normal! " .. ESC)
    return true
  end
  return false
end

return M
