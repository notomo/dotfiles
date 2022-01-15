if vim.fn.has("win32") == 1 and vim.fn.has("vim_starting") then
  vim.opt.runtimepath:prepend(vim.fn.expand("~/.vim/"))
  vim.opt.runtimepath:append(vim.fn.expand("~/.vim/after"))
end

vim.cmd([[
filetype off
filetype plugin indent off
]])

local safe_cmd = function(cmd)
  local ok, result = pcall(vim.cmd, cmd)
  if not ok then
    vim.api.nvim_echo({ { result, "Error" } }, true, {})
  end
end

safe_cmd([[runtime! rc/local/*.vim rc/local/*.lua]])
safe_cmd([[luafile ~/.vim/rc/option.lua]])
safe_cmd([[source ~/.vim/rc/autocmd.vim]])
safe_cmd([[luafile ~/.vim/rc/mapping.lua]])
safe_cmd([[luafile ~/.vim/rc/plugins/_manager.lua]])
safe_cmd([[runtime! rc/local/after/*.vim rc/local/after/*.lua]])
