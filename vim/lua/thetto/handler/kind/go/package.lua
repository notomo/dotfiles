local M = {}

function M.action_list_children(items)
  local item = items[1]
  if item == nil then
    return
  end
  return require("thetto").start("go/document", {
    source_opts = { package_name = item.value },
  })
end

function M.action_search(items)
  for _, item in ipairs(items) do
    vim.cmd.OpenBrowserSearch({ args = { "-go", item.value } })
  end
end

return require("thetto.core.kind").extend(M, "file/directory")
