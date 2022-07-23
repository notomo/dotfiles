local M = {}

function M.init()
  vim.cmd.Guifont({ args = { "MeiryoKe_Gothic:h14" }, bang = true })
  vim.cmd.GuiTabline("0")
  vim.cmd.GuiPopupmenu("0")
  vim.fn.GuiWindowMaximized(1)

  vim.keymap.set("n", "<Space>R", function()
    vim.fn.jobstart("nvim-qt.exe", { detach = true })
    vim.cmd.quitall()
  end)

  return nil
end

return M
