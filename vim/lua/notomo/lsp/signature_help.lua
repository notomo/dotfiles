local M = {}

local show = require("misclib.debounce").wrap(
  300,
  vim.schedule_wrap(function(bufnr)
    local client = vim.lsp.get_clients({
      bufnr = bufnr,
      method = vim.lsp.protocol.Methods.textDocument_signatureHelp,
    })[1]
    if not client then
      return
    end

    local height = 4
    local offset_y = vim.o.lines - vim.o.cmdheight - height - 2

    vim.lsp.buf.signature_help({
      max_height = height,
      offset_x = 9999,
      offset_y = offset_y,
      relative = "editor",
      anchor_bias = "below",
      focusable = false,
      silent = true,
      close_events = {
        "CursorMoved",
      },
    })
  end)
)

function M.setup()
  local bufnr = vim.api.nvim_get_current_buf()
  local group = vim.api.nvim_create_augroup("notomo.lsp.signature_help_" .. bufnr, {})
  vim.api.nvim_create_autocmd({ "InsertEnter", "TextChangedI" }, {
    buffer = bufnr,
    group = group,
    callback = function()
      show(bufnr)
    end,
  })
  vim.keymap.set("i", "[main_input]i", M._land, { buffer = true })
end

function M._land()
  local window_ids = vim.api.nvim_tabpage_list_wins(0)
  for _, window_id in ipairs(window_ids) do
    local config = vim.api.nvim_win_get_config(window_id)
    if config.relative ~= "" then
      local bufnr = vim.api.nvim_win_get_buf(window_id)
      vim.api.nvim_open_win(bufnr, false, {
        vertical = true,
        split = "right",
      })
      vim.api.nvim_win_close(window_id, true)
      return
    end
  end
end

return M
