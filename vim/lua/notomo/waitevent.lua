local M = {}

function M.setup(addr, path)
  vim.cmd.tabedit(path)

  local ch, err = vim.fn.sockconnect("tcp", addr)
  if err then
    error(err)
  end

  local group = vim.api.nvim_create_augroup("waitevent_" .. vim.fn.bufnr(), {})
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = group,
    buffer = 0,
    callback = function()
      vim.fn.chansend(ch, "done")
      vim.api.nvim_clear_autocmds({ group = group })
    end,
  })
  vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    group = group,
    buffer = 0,
    callback = function()
      vim.fn.chansend(ch, "cancel")
      vim.api.nvim_clear_autocmds({ group = group })
    end,
  })

  return ""
end

return M
