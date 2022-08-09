local M = {}

function M.setup(addr, path)
  local original_window_id = vim.api.nvim_get_current_win()
  local back = function()
    if not vim.api.nvim_win_is_valid(original_window_id) then
      return
    end
    vim.api.nvim_set_current_win(original_window_id)
  end

  vim.cmd.tabedit(path)
  vim.bo.bufhidden = "wipe"

  local window_id = vim.api.nvim_get_current_win()

  local ch, err = vim.fn.sockconnect("tcp", addr)
  if err then
    error(err)
  end

  local group = vim.api.nvim_create_augroup("waitevent_" .. vim.fn.bufnr(), {})
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = group,
    buffer = 0,
    callback = function()
      vim.fn.chansend(ch, "done")
      vim.api.nvim_clear_autocmds({ group = group })
      if vim.api.nvim_win_is_valid(window_id) then
        vim.api.nvim_win_close(window_id, true)
      end
      back()
    end,
  })
  vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    group = group,
    buffer = 0,
    callback = function()
      vim.fn.chansend(ch, "cancel")
      vim.api.nvim_clear_autocmds({ group = group })
      back()
    end,
  })

  return ""
end

return M
