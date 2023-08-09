local M = {}

vim.api.nvim_create_user_command("SearchEngine", function(command)
  local query = command.fargs[1]
  M.open([[https://google.com/search?q=]] .. query)
end, { nargs = 1 })

function M.open(url)
  if not vim.startswith(url, "http") then
    require("misclib.message").warn("invalid url: " .. url)
    return
  end
  vim.ui.open(url)
end

return M
