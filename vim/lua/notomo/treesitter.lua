local M = {}

function M.get_first_tree_root(str, language)
  local parser = vim.treesitter.get_string_parser(str, language, { injections = { [language] = "" } })
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

return M
