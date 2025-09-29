local M = {}

function M.input()
  local original_bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.bo[original_bufnr].buftype
  if buftype ~= "terminal" then
    error("unexpected buftype: " .. buftype)
  end

  local channel = vim.bo[original_bufnr].channel

  local file_path = require("notomo.lib.edit").scratch_path("prompt.txt", "text")
  if vim.fn.filereadable(file_path) ~= 1 then
    vim.fn.writefile({}, file_path, "p")
  end

  local window_id = vim.api.nvim_get_current_win()
  vim.api.nvim_open_win(0, true, {
    vertical = false,
    split = "below",
  })
  vim.cmd.edit(file_path)
  local bufnr = vim.api.nvim_get_current_buf()

  local group = vim.api.nvim_create_augroup("notomo.terminal.input", {})
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    buffer = bufnr,
    group = group,
    callback = function()
      vim.fn.chansend(channel, { vim.keycode("<C-c>") })

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      vim.fn.setreg("+", table.concat(lines, "\n"))

      vim.schedule(function()
        vim.api.nvim_set_current_win(window_id)
        vim.api.nvim_feedkeys("p", "nx", true)
        vim.cmd.startinsert({ bang = true })
      end)
    end,
  })
end

return M
