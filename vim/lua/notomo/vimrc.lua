local jobs = require("notomo/job")

local M = {}

M.fmt = function(cmd)
  local bufnr = vim.fn.bufnr("%")
  local cursors = {}
  for _, window in ipairs(vim.fn.win_findbuf(bufnr)) do
    cursors[window] = vim.api.nvim_win_get_cursor(window)
  end
  local origin_window = vim.api.nvim_get_current_win()
  local changedtick = vim.api.nvim_buf_get_changedtick(bufnr)

  local job = jobs.new(cmd, {
    on_stderr = jobs.print_stderr,
    on_exit = function(self, exit_code, _)
      if exit_code ~= 0 then
        return
      end
      if changedtick ~= vim.api.nvim_buf_get_changedtick(bufnr) then
        return
      end
      local lines = self:get_stdout()
      if lines[#lines] == "" then
        table.remove(lines, #lines)
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

      local current_window = vim.api.nvim_get_current_win()
      local current_bufnr = vim.fn.bufnr("%")
      vim.api.nvim_set_current_buf(bufnr)
      vim.api.nvim_command("update")
      vim.api.nvim_set_current_buf(current_bufnr)

      local line_count = vim.api.nvim_buf_line_count(bufnr)
      for window, cursor in pairs(cursors) do
        if cursor[1] > line_count then
          cursor[1] = line_count
        end
        vim.api.nvim_win_set_cursor(window, cursor)
      end
      if current_window == origin_window then
        table.remove(cursors, origin_window)
      end
      for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if cursors[window] ~= nil then
          vim.api.nvim_set_current_win(window)
          vim.api.nvim_command("redraw")
        end
      end
      vim.api.nvim_set_current_win(current_window)
    end,
  })

  local before_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  job:start()
  job.stdin:write(table.concat(before_lines, "\n"))
  job.stdin:close()
end

return M
