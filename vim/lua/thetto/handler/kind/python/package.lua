local M = {}

function M.action_show(_, items)
  local item = items[1]
  if item == nil then
    return
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = "wipe"
  vim.cmd.tabedit()
  vim.cmd.buffer({ count = bufnr })
  vim.opt_local.list = false

  return require("thetto.handler.kind.python.symbol").help(bufnr, item)
end

M.action_tab_open = M.action_show

function M.action_search(_, items)
  for _, item in ipairs(items) do
    vim.cmd.OpenBrowserSearch({ "-python", item.value })
  end
end

function M.action_list_children(_, items)
  local item = items[1]
  if item == nil then
    return
  end
  require("thetto").start("python/attribute", {
    source_opts = { package_name = item.value },
  })
end

M.default_action = "show"

return M
