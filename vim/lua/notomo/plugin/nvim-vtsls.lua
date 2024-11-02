vim.api.nvim_create_user_command("TSRename", function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.ui.input({ prompt = "Rename", default = path }, function(input)
    if not input or path == input then
      require("misclib.message").info("Canceled.")
      return
    end
    vim.cmd.VtsRename({ args = { path, input } })
  end)
end, {})
