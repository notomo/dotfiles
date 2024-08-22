local safe_call = function(f)
  local ok, result = pcall(f)
  if not ok then
    vim.api.nvim_echo({ { result, "Error" } }, true, {})
  end
end

local safe_require = function(name)
  local ok, result = pcall(require, name)
  if not ok then
    vim.api.nvim_echo({ { result, "Error" } }, true, {})
  end
end

vim.env.DOTFILES = vim.env.DOTFILES or vim.fn.expand("~/dotfiles")

safe_call(function()
  vim.cmd.runtime({ args = { "lua/notomo/local/*.lua" }, bang = true })
end)
safe_require("notomo.option")
safe_require("notomo.autocmd")
safe_require("notomo.mapping")
safe_require("notomo.plugin._manager")
safe_call(function()
  vim.cmd.runtime({ args = { "lua/notomo/local/after/*.lua" }, bang = true })
end)
