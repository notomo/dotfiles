local M = {}

local collect_one = function(full_name)
  local parts = vim.split(full_name, "/", true)
  local account_name = parts[1]
  local plugin_name = parts[2]

  local packpath = vim.opt.packpath:get()[1]
  local pattern = ("%s/pack/optpack/opt/%s/lua/**/*.lua"):format(packpath, plugin_name)
  local paths = vim.fn.glob(pattern, false, true)
  paths = vim.tbl_filter(function(path)
    return not path:find("/test/")
  end, paths)

  return vim.tbl_map(function(path)
    local index = path:find(plugin_name)
    local name = path:sub(index - 1)
    return {
      value = account_name .. name,
      path = path,
    }
  end, paths)
end

function M.collect()
  local items = {}
  vim.list_extend(items, collect_one("notomo/misclib.nvim"))
  vim.list_extend(items, collect_one("notomo/promise.nvim"))
  return items
end

M.kind_name = "file"

return M
