local M = {}

function M.open(url)
  if not vim.startswith(url, "http") then
    require("notomo.lib.message").warn("invalid url: " .. url)
    return
  end
  require("notomo.lib.message").info("Opening: " .. url)
  vim.ui.open(url, {
    cmd = vim.fn.has("wsl") == 1 and { "wslview" } or nil,
  })
end

return M
