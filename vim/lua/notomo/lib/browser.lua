local M = {}

function M.open(url)
  if not vim.startswith(url, "http") then
    require("misclib.message").warn("invalid url: " .. url)
    return
  end
  if vim.fn.has("wsl") ~= 1 then
    vim.ui.open(url)
    return
  end

  local cmd = { "wslview", url }
  local result = vim.system(cmd, { text = true, detach = true }):wait()
  if result.code ~= 0 then
    require("misclib.message").warn(("failed browser.open: exit_code=%d"):format(result.code))
  end
end

return M
