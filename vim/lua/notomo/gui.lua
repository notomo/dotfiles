local M = {}

function M.init()
  vim.cmd([[
Guifont! MeiryoKe_Gothic:h14
GuiTabline 0
GuiPopupmenu 0
]])
  vim.fn.GuiWindowMaximized(1)

  vim.keymap.set("n", "<Space>R", function()
    vim.fn.jobstart("nvim-qt.exe", { detach = true })
    vim.cmd([[quitall]])
  end)

  return nil
end

return M
