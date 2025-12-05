local M = {}

function M.open()
  vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = vim.api.nvim_create_augroup("notomo.lib.prompt", {}),
    pattern = { "*/text/prompt.txt" },
    callback = function()
      vim.keymap.set("n", "[exec]I", function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local text = table.concat(lines, "\n")
        require("notomo.lib.prompt").send(text)
      end, { buffer = true })

      vim.keymap.set("x", "[exec]I", function()
        local lines = require("notomo.lib.edit").get_selected_lines()
        require("misclib.visual_mode").leave()
        local text = table.concat(lines, "\n")
        require("notomo.lib.prompt").send(text)
      end, { buffer = true })

      vim.keymap.set("n", "[exec]H", function()
        local terminal = require("notomo.lib.prompt").terminal()
        vim.fn.chansend(terminal.channel, { vim.keycode("<C-c>") })
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

  local cwd = vim.fn.getcwd()

  if not window_id then
    local opened = vim.api.nvim_open_win(0, true, {
      vertical = false,
      split = "below",
    })
    vim.cmd.edit(file_path)
    vim.cmd.wincmd("=")
    vim.w[opened].notomo_disable_autocd = true
    vim.fn.chdir(cwd, "window")
    return
  end

  vim.api.nvim_tabpage_set_win(0, window_id)
  vim.w[window_id].notomo_disable_autocd = true
  vim.fn.chdir(cwd, "window")
end

function M.terminal()
  local terminal = vim
    .iter(vim.api.nvim_tabpage_list_wins(0))
    :map(function(window_id)
      local bufnr = vim.api.nvim_win_get_buf(window_id)
      if vim.bo[bufnr].buftype ~= "terminal" then
        return nil
      end
      return {
        window_id = window_id,
        channel = vim.bo[bufnr].channel,
      }
    end)
    :find(function(x)
      return x ~= nil
    end)
  if not terminal then
    error("no terminal in tabpage")
  end
  return terminal
end

function M.send(text)
  local terminal = M.terminal()

  vim.fn.setreg("+", text)

  local prompt_window_id = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(terminal.window_id)
  vim.api.nvim_win_close(prompt_window_id, true)

  require("misclib.cursor").to_bottom(terminal.window_id)
  vim.api.nvim_feedkeys("p", "nx", true)
  vim.cmd.startinsert({ bang = true })
end

return M
