local M = {}

function M.warn(msg)
  vim.api.nvim_echo({ { "[notomo]: " .. msg, "WarningMsg" } }, true, {})
end

return M
