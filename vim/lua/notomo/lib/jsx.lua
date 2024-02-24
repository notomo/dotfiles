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

function M.select_tag()
  local node = vim.treesitter.get_node({})
  local self_closing = require("notomo.lib.treesitter").find_ancestor(node, "jsx_self_closing_element", true)
  vim.cmd.normal({ args = { "m'" }, bang = true })
  vim.cmd.TSTextobjectSelect("@jsx_element.outer")
  require("nvim-treesitter.incremental_selection").init_selection()
  if self_closing then
    return
  end
  require("nvim-treesitter.incremental_selection").node_incremental()
end

function M.cursor_on_string(base_node)
  if not base_node then
    return false
  end
  local typ = base_node:type()
  return vim.tbl_contains({ "string_fragment", "template_string" }, typ)
end

function M.select_class_name(str_node)
  local _, start_col = str_node:start()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local column = cursor[2] - start_col + 1
  local str = vim.treesitter.get_node_text(str_node, 0)

  local before = str:sub(1, column - 1)
  local before_index = before:reverse():find(" ")
  if before_index then
    before_index = before_index
  else
    before_index = #before
  end

  local after = str:sub(column)
  local after_index = after:find(" ")
  if after_index then
    after_index = after_index - 1
  else
    after_index = #after
  end

  local start_pos = { cursor[1], cursor[2] - before_index }
  local end_pos = { cursor[1], cursor[2] + after_index - 1 }
  vim.api.nvim_buf_set_mark(0, "<", start_pos[1], start_pos[2], {})
  vim.api.nvim_buf_set_mark(0, ">", end_pos[1], end_pos[2], {})

  vim.cmd.normal({ args = { "gv" }, bang = true })
end

return M
