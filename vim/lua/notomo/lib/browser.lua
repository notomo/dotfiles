local M = {}

function M.open(url)
  if not vim.startswith(url, "http") then
    require("misclib.message").warn("invalid url: " .. url)
    return
  end
  vim.ui.open(url)
end

return M
