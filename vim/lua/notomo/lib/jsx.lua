local M = {}

local find_parent = function()
  local node = vim.treesitter.get_node({})
  if not node then
    return nil
  end

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
    require("notomo.lib.message").warn("not found parent")
    return
  end

  local child = vim.iter(parent:iter_children()):find(function(n, field_name)
    return not field_name and regex:match_str(n:type())
  end)
  if not child then
    require("notomo.lib.message").warn("not found children")
    return
  end

  local row, column = child:range()
  vim.api.nvim_win_set_cursor(0, { row + 1, column })
end

function M.go_to_last_child()
  local parent = find_parent()
  if not parent then
    require("notomo.lib.message").warn("not found parent")
    return
  end

  local tbl = vim.iter(parent:iter_children()):totable()
  local child = vim.iter(tbl):rfind(function(n, field_name)
    return not field_name and regex:match_str(n:type())
  end)
  if not child then
    require("notomo.lib.message").warn("not found children")
    return
  end

  local _, _, row, column = child:range()
  vim.api.nvim_win_set_cursor(0, { row + 1, math.max(0, column - 1) }) -- HACk
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

local get_tag_name_node = function(jsx_node, field_name)
  local open_tag = jsx_node:field(field_name)[1]
  if not open_tag then
    return "not found jsx " .. field_name
  end

  local open_tag_name = open_tag:field("name")[1]
  if not open_tag_name then
    return ("not found %s name"):format(field_name)
  end

  return open_tag_name
end

function M.change_tag()
  local node = vim.treesitter.get_node({})
  local jsx_node = require("notomo.lib.treesitter").find_ancestor(node, "jsx_element", true)
  if not jsx_node then
    require("notomo.lib.message").warn("not found jsx_element node in ancestor")
    return
  end

  local open_tag = get_tag_name_node(jsx_node, "open_tag")
  if type(open_tag) == "string" then
    require("notomo.lib.message").warn(open_tag)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local current_tag_name = vim.treesitter.get_node_text(open_tag, bufnr)

  vim.ui.input({
    prompt = "Change tag from: " .. current_tag_name,
    default = current_tag_name,
  }, function(input)
    if not input or input == "" or input == current_tag_name then
      require("notomo.lib.message").info("Canceled.")
      return
    end

    do
      local start_row, start_col, end_row, end_col = open_tag:range()
      vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { input })
    end

    -- NOTE: get node after updating buffer
    local close_tag = get_tag_name_node(jsx_node, "close_tag")
    if type(close_tag) == "string" then
      require("notomo.lib.message").warn(close_tag)
      return
    end
    do
      local start_row, start_col, end_row, end_col = close_tag:range()
      vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { input })
    end
  end)
end

function M.add_component_parameter()
  local node = vim.treesitter.get_node({})
  local param_node = require("notomo.lib.treesitter").find_ancestor(node, "required_parameter", true)
  if not param_node then
    require("notomo.lib.message").warn("not found required_parameter node in ancestor")
    return
  end

  local pattern_node = param_node:field("pattern")[1]
  if not pattern_node then
    require("notomo.lib.message").warn("not found pattern node in ancestor")
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  vim.ui.input({
    prompt = "Add parameter",
  }, function(input)
    if not input or input == "" then
      require("notomo.lib.message").info("Canceled.")
      return
    end

    do
      local start_row, _, end_row, end_col = pattern_node:range()
      local prefix = start_row == end_row and ", " or ""
      vim.api.nvim_buf_set_text(bufnr, end_row, end_col - 1, end_row, end_col - 1, { prefix .. input, "" })
    end

    local type_node = param_node:field("type")[1]
    if not type_node then
      require("notomo.lib.message").warn("not found type node in ancestor")
      return
    end

    do
      local start_row, _, end_row, end_col = type_node:range()
      local prefix = start_row == end_row and ", " or ""
      vim.api.nvim_buf_set_text(
        bufnr,
        end_row,
        end_col - 1,
        end_row,
        end_col - 1,
        { prefix .. input .. ": string", "" }
      )
    end

    vim.schedule(function()
      local new_node = vim.treesitter.get_node({})
      if not new_node then
        return
      end

      local new_param_node = require("notomo.lib.treesitter").find_ancestor(new_node, "required_parameter", true)
      if not new_param_node then
        return
      end

      local new_type_node = new_param_node:field("type")[1]
      local object_type_node = new_type_node:named_child(0)
      local target_node =
        object_type_node:named_child(object_type_node:named_child_count() - 1):field("type")[1]:named_child(0)

      local start_row, start_col, end_row, end_col = target_node:range()
      vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
      vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col - 1, {})

      vim.cmd.normal({ args = { "gv" }, bang = true })
      vim.api.nvim_feedkeys(vim.keycode("<C-g>"), "n", true)
    end)
  end)
end

function M.unwrap()
  local bufnr = vim.api.nvim_get_current_buf()
  local node = vim.treesitter.get_node({
    bufnr = bufnr,
  })
  if not node then
    return
  end

  local jsx_element = require("notomo.lib.treesitter").find_ancestor(node, "jsx_element", true)
  if not jsx_element then
    return
  end

  local child = jsx_element:child(1)
  local child_node_text = vim.treesitter.get_node_text(child, bufnr)

  local s_row, s_col, e_row, e_col = jsx_element:range()
  vim.api.nvim_buf_set_text(bufnr, s_row, s_col, e_row, e_col, vim.split(child_node_text, "\n", { plain = true }))

  require("misclib.visual_mode").leave()
end

return M
