local M = {}

local to_item = function(match_tree, bufnr, path, depth)
  local name_node = match_tree.captured.name
  local row, column = name_node:start()
  local end_row, end_column = name_node:end_()

  local scope_text = vim.treesitter.get_node_text(match_tree.scope_node, bufnr)
  local is_tag = vim.startswith(scope_text, "<")

  local text = vim.treesitter.get_node_text(name_node, bufnr)
  local newline_index = text:find("\n")
  local first_line = newline_index and text:sub(0, newline_index - 1) or text
  local indent_depth = match_tree.captured.level and #vim.treesitter.get_node_text(match_tree.captured.level, bufnr) - 1
    or depth
  local indent = (" "):rep(indent_depth * 2)
  local tag_marker = is_tag and "<" or ""

  return {
    value = indent == "" and tag_marker .. first_line .. " >" or indent .. tag_marker .. first_line,
    row = row + 1,
    column = column,
    end_row = end_row,
    end_column = end_column,
    path = path,
  }
end

function M._collect(match_tree, bufnr, path, depth)
  local items = { to_item(match_tree, bufnr, path, depth) }
  for _, child in ipairs(match_tree.children) do
    vim.list_extend(items, M._collect(child, bufnr, path, depth + 1))
  end
  return items
end

function M.collect(source_ctx)
  local bufnr = source_ctx.bufnr

  require("aerial")
  local match_tree = require("notomo.lib.treesitter.match_tree").get(bufnr, "aerial", "symbol")

  local path = vim.api.nvim_buf_get_name(bufnr)

  local items = {}
  local depth = 0
  for _, child in ipairs(match_tree.children) do
    vim.list_extend(items, M._collect(child, bufnr, path, depth))
  end
  return items
end

M.kind_name = "file"

return M
