local M = {}

local find_parent = function()
  local node = vim.treesitter.get_node({})

  local parent = require("notomo.lib.treesitter").find_ancestor(node, "jsx_element", true)
  if parent then
    return parent
  end

  return vim.iter(node:iter_children()):find(function(n)
    return n:type() == "jsx_element"
  end)
end

local regex = vim.regex([[\vjsx_.*]])

function M.go_to_first_child()
  local parent = find_parent()
  if not parent then
    require("misclib.message").warn("not found parent")
    return
  end

  local child = vim.iter(parent:iter_children()):find(function(n, field_name)
    return not field_name and regex:match_str(n:type())
  end)
  if not child then
    require("misclib.message").warn("not found children")
    return
  end

  local row, column = child:range()
  vim.api.nvim_win_set_cursor(0, { row + 1, column })
end

function M.go_to_last_child()
  local parent = find_parent()
  if not parent then
    require("misclib.message").warn("not found parent")
    return
  end

  local tbl = vim.iter(parent:iter_children()):totable()
  local child = vim.iter(tbl):rfind(function(n, field_name)
    return not field_name and regex:match_str(n:type())
  end)
  if not child then
    require("misclib.message").warn("not found children")
    return
  end

  local _, _, row, column = child:range()
  vim.api.nvim_win_set_cursor(0, { row + 1, math.max(0, column - 1) }) -- HACk
end

return M
