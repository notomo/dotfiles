local safe_cmd = function(cmd)
  local ok, result = pcall(vim.cmd, cmd)
  if not ok then
    vim.api.nvim_echo({ { result, "Error" } }, true, {})
  end
end

safe_cmd([[runtime! rc/local/*.lua]])
safe_cmd([[luafile ~/dotfiles/vim/lua/notomo/option.lua]])
safe_cmd([[luafile ~/dotfiles/vim/lua/notomo/autocmd.lua]])
safe_cmd([[luafile ~/dotfiles/vim/lua/notomo/mapping/init.lua]])
safe_cmd([[luafile ~/dotfiles/vim/lua/notomo/plugin/_manager.lua]])
safe_cmd([[runtime! rc/local/after/*.lua]])
