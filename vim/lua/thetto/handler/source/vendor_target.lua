local M = {}

local collect_one = function(full_name)
  local parts = vim.split(full_name, "/", { plain = true })
  local account_name = parts[1]
  local plugin_name = parts[2]

  local plugin = require("optpack").get(plugin_name)
  if not plugin then
    return {}
  end
  local pattern = ("%s/lua/**/*.lua"):format(plugin.directory)

  local paths = vim.fn.glob(pattern, false, true)
  paths = vim
    .iter(paths)
    :filter(function(path)
      return not path:find("/vendor/") and not path:find("/test/helper%.lua")
    end)
    :totable()

  return vim
    .iter(paths)
    :map(function(path)
      local index = path:find(plugin_name)
      local name = path:sub(index - 1)
      return {
        value = account_name .. name,
        path = path,
      }
    end)
    :totable()
end

function M.collect()
  local items = {}
  for _, name in ipairs({
    "notomo/promise.nvim",
    "notomo/misclib.nvim",
    "notomo/assertlib.nvim",
  }) do
    vim.list_extend(items, collect_one(name))
  end
  return items
end

M.kind_name = "file"

M.actions = {
  action_add = function(items)
    require("vendorlib").add(
      vim
        .iter(items)
        :map(function(item)
          return item.value
        end)
        :totable(),
      { path = "spec/lua/%s/vendorlib.lua" }
    )
  end,
  default_action = "add",
}

return M
