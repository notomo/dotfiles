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

function M.get_near_function_name()
  local bufnr = 0
  local language = vim.bo[bufnr].filetype

  local root, err = require("notomo.treesitter").get_first_tree_root(bufnr, language)
  if err then
    return nil, err
  end

  local row = unpack(vim.api.nvim_win_get_cursor(0))
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
    return nil
  end

  local text = vim.treesitter.query.get_node_text(last_node, bufnr):gsub('"', ""):gsub("'", "")
  return text
end

return M
