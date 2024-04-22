local safe_cmd = function(cmd)
  local ok, result = pcall(vim.cmd, cmd)
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

-- temporary workaround
vim.tbl_islist = vim.tbl_islist or vim.islist

vim.env.DOTFILES = vim.env.DOTFILES or vim.fn.expand("~/dotfiles")

safe_cmd([[runtime! lua/notomo/local/*.lua]])
safe_require("notomo.option")
safe_require("notomo.autocmd")
safe_require("notomo.mapping")
safe_require("notomo.plugin._manager")
safe_cmd([[runtime! lua/notomo/local/after/*.lua]])
