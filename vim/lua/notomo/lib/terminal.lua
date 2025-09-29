local M = {}

function M.input()
  if vim.bo.buftype ~= "terminal" then
    error("unexpected buftype: " .. vim.bo.buftype)
  end

  local file_path = require("notomo.lib.edit").scratch_path("prompt.txt", "text")
  if vim.fn.filereadable(file_path) ~= 1 then
    vim.fn.writefile({}, file_path, "p")
  end

  local channel = vim.bo.channel
  local original_window_id = vim.api.nvim_get_current_win()

  local window_id = vim.api.nvim_open_win(0, true, {
    vertical = false,
    split = "below",
  })
  vim.cmd.edit(file_path)

  local group = vim.api.nvim_create_augroup("notomo.terminal.input", {})
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = group,
    callback = function()
      if vim.api.nvim_get_current_win() ~= window_id then
        return
      end

      vim.fn.chansend(channel, { vim.keycode("<C-c>") })

      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      vim.fn.setreg("+", table.concat(lines, "\n"))

      vim.schedule(function()
        vim.api.nvim_set_current_win(original_window_id)
        vim.api.nvim_feedkeys("p", "nx", true)
        vim.cmd.startinsert({ bang = true })
      end)
    end,
  })

  vim.api.nvim_create_autocmd({ "WinClosed" }, {
    group = group,
    callback = function(args)
      if tonumber(args.file) ~= window_id then
        return
      end
      vim.api.nvim_clear_autocmds({ group = group })
      return true
    end,
  })
end

return M
