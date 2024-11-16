vim.api.nvim_create_user_command("TSRename", function()
  local path = vim.api.nvim_buf_get_name(0)
  if vim.bo.filetype == "kivi-file" then
    path = vim.fn.getcwd()
  end
  vim.ui.input({ prompt = "Rename", default = path }, function(input)
    if not input or path == input then
      return
    end
    vim.cmd.VtsRename({ args = { path, input } })
  end)
end, {})

vim.api.nvim_create_user_command("RestartTsserver", function()
  vim.cmd.VtsExec({ args = { "restart_tsserver" } })
end, {})
vim.api.nvim_create_user_command("TSRemoveUnused", function()
  vim.cmd.VtsExec({ args = { "remove_unused" } })
end, {})
vim.api.nvim_create_user_command("TSRemoveUnusedImports", function()
  vim.cmd.VtsExec({ args = { "remove_unused_imports" } })
end, {})
vim.api.nvim_create_user_command("TSAddMissingImports", function()
  vim.cmd.VtsExec({ args = { "add_missing_imports" } })
end, {})
vim.api.nvim_create_user_command("TSOrganizeImports", function()
  vim.cmd.VtsExec({ args = { "organize_imports" } })
end, {})
vim.api.nvim_create_user_command("TSFixAll", function()
  vim.cmd.VtsExec({ args = { "fix_all" } })
end, {})
