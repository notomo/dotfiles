local M = {}

function M.get_first_tree_root(source, language)
  local parser
  if type(source) == "string" then
    parser = vim.treesitter.get_string_parser(source, language, { injections = { [language] = "" } })
  else
    parser = vim.treesitter.get_parser(source, language, { injections = { [language] = "" } })
  end
  local trees = parser:parse()
  return trees[1]:root()
end

function M.get_captures(match, query, handlers)
  local captures = {}
  for id, node in pairs(match) do
    local captured = query.captures[id]
    local f = handlers[captured]
    if f then
      f(captures, node)
    end
  end
  return captures
end

function M.remove_indent(str)
  local lines = vim.split(str, "\n", true)
  lines = vim.tbl_map(function(line)
    return line:gsub("^%s+", "")
  end, lines)
  return table.concat(lines, " ")
end

function M._get_near_function_node(bufnr)
  local language = vim.bo[bufnr].filetype

  local root, err = require("notomo.treesitter").get_first_tree_root(bufnr, language)
  if err then
    return nil, err
  end

  local row = unpack(vim.api.nvim_win_get_cursor(0))

  require("nvim-treesitter")
  local query = vim.treesitter.get_query(language, "locals")

  local last_node
  for id, node, _ in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if name == "definition.function" then
      last_node = node
    end
    local start = node:start()
    if start > row then
      break
    end
  end
  if not last_node then
    return nil, "not found near function node"
  end
  return last_node
end

function M.get_near_function_name()
  local bufnr = 0
  local node, err = M._get_near_function_node(bufnr)
  if err then
    return nil, err
  end
  local text = vim.treesitter.query.get_node_text(node, bufnr):gsub('"', ""):gsub("'", "")
  return text
end

function M.get_current_function_range()
  local bufnr = 0
  local node, err = M._get_near_function_node(bufnr)
  if err then
    return nil, err
  end
  local range_node = node
  for _ = 0, 2, 1 do
    range_node = range_node:parent()
    local s, _, e, _ = range_node:range()
    if s ~= e then
      return { s, e }
    end
  end
  return nil, "not found"
end

return M
