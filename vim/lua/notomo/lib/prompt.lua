local M = {}

function M.open()
  vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = vim.api.nvim_create_augroup("notomo.lib.prompt", {}),
    pattern = { "*/text/prompt.txt" },
    callback = function()
      vim.keymap.set("n", "[exec]I", function()
        require("notomo.lib.prompt").send()
      end, { buffer = true })
    end,
  })

  local file_path = require("notomo.lib.edit").scratch_path("prompt.txt", "text")
  if vim.fn.filereadable(file_path) ~= 1 then
    vim.fn.writefile({}, file_path, "p")
  end

  local window_id = vim.iter(vim.api.nvim_tabpage_list_wins(0)):find(function(window)
    local bufnr = vim.api.nvim_win_get_buf(window)
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == file_path then
      return window
    end
  end)

  if not window_id then
    vim.api.nvim_open_win(0, true, {
      vertical = false,
      split = "below",
    })
    vim.cmd.edit(file_path)
    return
  end

  vim.api.nvim_tabpage_set_win(0, window_id)
end

function M.send()
  local terminal = vim
    .iter(vim.api.nvim_tabpage_list_wins(0))
    :map(function(window_id)
      local bufnr = vim.api.nvim_win_get_buf(window_id)
      if vim.bo[bufnr].buftype ~= "terminal" then
        return nil
      end
      return {
        channel = vim.bo[bufnr].channel,
        window_id = window_id,
      }
    end)
    :find(function(x)
      return x ~= nil
    end)
  if not terminal then
    error("no terminal in tabpage")
  end

  vim.fn.chansend(terminal.channel, { vim.keycode("<C-c>") })

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  vim.fn.setreg("+", table.concat(lines, "\n"))

  vim.schedule(function()
    vim.api.nvim_set_current_win(terminal.window_id)
    vim.api.nvim_feedkeys("p", "nx", true)
    vim.cmd.startinsert({ bang = true })
  end)
end

return M
