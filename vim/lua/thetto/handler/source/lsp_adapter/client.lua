local M = {}

function M.collect()
  local clients = vim.lsp.get_active_clients()
  local items = {}
  for _, client in ipairs(clients) do
    local config = {
      cmd = client.config.cmd,
      cmd_cwd = client.config.cmd_cwd,
      root_dir = client.config.root_dir,
    }
    local desc = ("%d %s %s"):format(client.id, client.name, vim.inspect(config, { newline = " ", indent = "" }))
    table.insert(items, {
      value = client.name,
      desc = desc,
      column_offsets = {
        value = #tostring(client.id) + 1,
      },
    })
  end
  return items
end

M.kind_name = "word"

return M
