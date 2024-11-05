local M = {}

local new_match_tree = function(scope_node, captured)
  return {
    scope_node = scope_node,
    captured = captured or {},
    children = {},
  }
end

function M.get(bufnr, query_name, scope_name)
  local filetype = vim.bo[bufnr].filetype
  local language = vim.treesitter.language.get_lang(filetype)
  local query = vim.treesitter.query.get(language, query_name)
  if not query then
    local err = ("query not found: language=%s query_name=%s"):format(language, query_name)
    error(err)
  end

  local root = require("misclib.treesitter").get_first_tree_root(bufnr, language)
  if type(root) == "string" then
    local err = root
    error(err)
  end

  local match_tree = new_match_tree(root)

  for _, match in query:iter_matches(root, bufnr, 0, -1) do
    local captured = require("misclib.treesitter").get_captures(match, query, function(tbl, capture_name, tsnode)
      tbl[capture_name] = tsnode
    end)
    local scope_node = captured[scope_name]
    if scope_node then
      M._add(match_tree, scope_node, captured)
    end
  end

  return match_tree
end

function M._add(match_tree, scope_node, captured)
  if not M._contains(match_tree.scope_node, scope_node) then
    return false
  end

  for _, child in ipairs(match_tree.children) do
    local added = M._add(child, scope_node, captured)
    if added then
      return true
    end
  end

  local child = new_match_tree(scope_node, captured)
  table.insert(match_tree.children, child)

  return true
end

function M._contains(scope_node1, scope_node2)
  local range = { vim.treesitter.get_node_range(scope_node2) }
  return vim.treesitter.node_contains(scope_node1, range)
end

return M
