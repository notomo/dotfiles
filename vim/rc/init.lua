local safe_cmd = function(cmd)
  local ok, result = pcall(vim.cmd, cmd)
  if not ok then
    vim.api.nvim_echo({ { result, "Error" } }, true, {})
  end
end

safe_cmd([[runtime! rc/local/*.lua]])
safe_cmd([[luafile ~/.vim/rc/option.lua]])
safe_cmd([[luafile ~/.vim/rc/autocmd.lua]])
safe_cmd([[luafile ~/.vim/rc/mapping.lua]])
safe_cmd([[luafile ~/.vim/rc/plugins/_manager.lua]])
safe_cmd([[runtime! rc/local/after/*.lua]])
