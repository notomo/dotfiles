return function(opts, on_confirm)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local default_line = opts.default or ""
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { default_line })
  vim.bo[bufnr].bufhidden = "wipe"

  vim.api.nvim_echo({ { "" } }, false, {})

  local window_id = vim.api.nvim_open_win(bufnr, true, {
    width = vim.o.columns,
    height = 2,
    relative = "editor",
    row = vim.o.lines - vim.o.cmdheight,
    col = 0,
    external = false,
    style = "minimal",
    zindex = 200,
  })
  local prompt = opts.prompt or ""
  vim.wo[window_id].winbar = " " .. prompt
  vim.wo[window_id].winhighlight = "Normal:Normal,SignColumn:Normal"
  vim.wo[window_id].signcolumn = "yes:1"
  vim.cmd.normal({ args = { "$" }, bang = true })

  local cancel = function()
    on_confirm()
    if vim.api.nvim_win_is_valid(window_id) then
      vim.api.nvim_win_close(window_id, true)
    end
    vim.api.nvim_echo({ { "Canceled: " .. prompt .. default_line } }, true, {})
  end

  local group = vim.api.nvim_create_augroup("notomo_ui_input", {})
  vim.api.nvim_create_autocmd({ "WinClosed", "WinLeave", "TabLeave", "BufLeave", "BufWipeout" }, {
    group = group,
    buffer = bufnr,
    callback = cancel,
    once = true,
  })
  vim.keymap.set("n", "q", cancel)

  local confirm = function()
    vim.cmd.stopinsert()

    local line = vim.fn.getline(".")
    if line == default_line then
      return cancel()
    end

    on_confirm(line)

    vim.api.nvim_clear_autocmds({ group = group })
    if vim.api.nvim_win_is_valid(window_id) then
      vim.api.nvim_win_close(window_id, true)
    end
  end

  vim.keymap.set({ "n", "i" }, "<CR>", confirm, { buffer = bufnr })
  vim.keymap.set({ "i" }, "<C-m>", confirm, { buffer = bufnr })
  vim.keymap.set("n", "[file]w", confirm, { buffer = bufnr })
end
