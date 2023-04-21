local M = {}

local create_cancel = function(on_confirm, close)
  local canceled = false
  return function()
    if canceled then
      return
    end
    canceled = true
    close()
    on_confirm()
  end
end

local group = vim.api.nvim_create_augroup("notomo_ui_input", {})
local create_confirm = function(on_confirm, close)
  return function()
    vim.cmd.stopinsert()

    local line = vim.fn.getline(".")
    close()
    on_confirm(line)
  end
end

local create_inputter_buffer = function(default_line)
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { default_line })
  vim.bo[bufnr].bufhidden = "wipe"

  vim.api.nvim_buf_attach(bufnr, false, {
    on_lines = function()
      if vim.api.nvim_buf_line_count(bufnr) == 1 then
        return
      end
      vim.schedule(function()
        vim.api.nvim_buf_set_lines(bufnr, 1, -1, false, {})
      end)
    end,
  })
  return bufnr
end

local open_inputter = function(bufnr)
  local window_id = vim.api.nvim_open_win(bufnr, true, {
    width = vim.o.columns,
    height = 1,
    relative = "editor",
    row = vim.o.lines - vim.o.cmdheight,
    col = 0,
    external = false,
    style = "minimal",
    zindex = 200,
  })
  vim.wo[window_id].winhighlight = "Normal:Normal,SignColumn:Normal"
  vim.wo[window_id].signcolumn = "yes:1"
  return window_id
end

local open_prompt = function(prompt, base_window_id)
  local prompt_line = prompt or ""
  local bufnr = vim.api.nvim_create_buf(false, true)
  local lines = vim.split(prompt_line, "\n", { plain = true })
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.bo[bufnr].bufhidden = "wipe"
  local window_id = vim.api.nvim_open_win(bufnr, false, {
    relative = "win",
    win = base_window_id,
    width = vim.o.columns,
    height = #lines,
    row = 0,
    col = 0,
    anchor = "SW",
    external = false,
    focusable = false,
    style = "minimal",
    zindex = 200,
  })
  vim.wo[window_id].winhighlight = "Normal:StatusLine,SignColumn:StatusLine"
  vim.wo[window_id].signcolumn = "yes:1"
  return window_id
end

local create_close = function(window_id, prompt_window_id, save_history)
  return function()
    save_history()
    vim.api.nvim_clear_autocmds({ group = group })
    if vim.api.nvim_win_is_valid(window_id) then
      vim.api.nvim_win_close(window_id, true)
    end
    if vim.api.nvim_win_is_valid(prompt_window_id) then
      vim.api.nvim_win_close(prompt_window_id, true)
    end
  end
end

function M.open(opts, on_confirm)
  local default_line = opts.default or ""
  local bufnr = create_inputter_buffer(default_line)
  local window_id = open_inputter(bufnr)
  local prompt_window_id = open_prompt(opts.prompt, window_id)

  if default_line == "" then
    vim.cmd.startinsert()
  end
  vim.cmd.normal({ args = { "$" }, bang = true })
  vim.api.nvim_echo({ { "" } }, false, {})

  local save_history = function()
    local input_line = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)[1]
    if input_line == "" then
      return
    end
    vim.fn.histadd("input", input_line)
  end

  local history_offset = 0
  local recall_history = function(offset)
    if history_offset == 0 then
      save_history()
      history_offset = -1
    end

    local min = -vim.fn.histnr("input")
    local max = 0
    local line = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)[1]
    local next_index = history_offset
    local index = history_offset
    for _ = 0, vim.fn.histnr("input"), 1 do
      index = index + offset
      index = math.min(index, max)
      index = math.max(index, min)
      local history = vim.fn.histget("input", index)
      if history ~= "" then
        line = history
        next_index = index
        break
      end
      if index <= min or index >= max then
        break
      end
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, { vim.split(line, "\n", { plain = true })[1] })
    require("misclib.cursor").set_column(#line)

    history_offset = next_index
  end

  local close = create_close(window_id, prompt_window_id, save_history)
  local cancel = create_cancel(on_confirm, close)
  local confirm = create_confirm(on_confirm, close)

  vim.api.nvim_create_autocmd({ "WinClosed", "WinLeave", "TabLeave", "BufLeave", "BufWipeout" }, {
    group = group,
    buffer = bufnr,
    callback = cancel,
    once = true,
  })
  vim.keymap.set("n", "q", cancel)
  vim.keymap.set({ "n", "i" }, "<CR>", confirm, { buffer = bufnr })
  vim.keymap.set({ "i" }, "<C-m>", confirm, { buffer = bufnr })
  vim.keymap.set("n", "[file]w", confirm, { buffer = bufnr })

  vim.keymap.set("i", "<C-j>", function()
    recall_history(1)
  end, { buffer = bufnr })
  vim.keymap.set("i", "<C-k>", function()
    recall_history(-1)
  end, { buffer = bufnr })
end

return M
