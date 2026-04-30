local M = {}

function M.windows()
  local window_ids = vim.api.nvim_tabpage_list_wins(0)
  if #window_ids ~= 2 then
    return require("notomo.lib.message").warn(("must have 2 windows, but: %d"):format(#window_ids))
  end
  for _, window_id in ipairs(window_ids) do
    vim.api.nvim_win_call(window_id, function()
      vim.cmd.diffthis()
    end)
  end
end

function M.selected()
  require("notomo.lib.edit").open_selected()

  local register_lines = vim.fn.getreg("+", true, true)
  vim.cmd.vnew()
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(0, 0, -1, false, register_lines)

  M.windows()
end

return M
