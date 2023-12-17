local M = {}

M.filetypes = {
  go = true,
  typescript = true,
  c = true,
}

function M.attach(client, bufnr)
  local filetype = vim.bo[bufnr].filetype
  if M.filetypes[filetype] and client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

function M.setup()
  local filetype = vim.bo.filetype
  if not M.filetypes[filetype] then
    return
  end

  local window_id = vim.api.nvim_get_current_win()
  if not require("misclib.window").is_floating(window_id) then
    vim.wo[window_id].winbar = [[%!v:lua.require("stlparts").build("navic")]]
  end
end

return M
