local M = {}

local remove_indent = function(str)
  local lines = vim.split(str, "\n", true)
  lines = vim.tbl_map(function(line)
    return line:gsub("^%s+", "")
  end, lines)
  return table.concat(lines, " ")
end

local collect = function(path, query, language)
  local f = io.open(path, "r")
  if not f then
    return nil, "cannot read: " .. path
  end

  local str = f:read("*a")
  f:close()

  local root = require("notomo.treesitter").get_first_tree_root(str, language)
  local items = {}
  for _, match in query:iter_matches(root, str, 0, -1) do
    local captured = require("notomo.treesitter").get_captures(match, query, {
      ["autocmd"] = function(tbl, tsnode)
        tbl.autocmd = tsnode
      end,
      ["autocmd.events"] = function(tbl, tsnode)
        tbl.events = tsnode
      end,
      ["autocmd.opts"] = function(tbl, tsnode)
        tbl.opts = tsnode
      end,
    })
    local row = captured.autocmd:start()
    local events = require("notomo.treesitter").remove_indent(vim.treesitter.get_node_text(captured.events, str))
    local opts = require("notomo.treesitter").remove_indent(vim.treesitter.get_node_text(captured.opts, str))
    local texts = { events, opts }
    local text = table.concat(texts, " ")
    table.insert(items, {
      value = text,
      path = path,
      row = row + 1,
    })
  end
  return items
end

function M.collect()
  local language = "lua"
  if not vim.treesitter.language.require_language(language, nil, true) then
    return nil, nil, ("not found tree-sitter parser for `%s`"):format(language)
  end

  local paths = vim.fn.glob("~/dotfiles/vim/**/*.lua", false, true)
  local query = vim.treesitter.parse_query(
    "lua",
    [[
(
  (function_call
    name: (_) @autocmd (#match? @autocmd "^vim.api.nvim_create_autocmd$")
    arguments: (arguments
      .
      (_) @autocmd.events
      .
      (_) @autocmd.opts
      .
    )
  )
)
]]
  )

  local items = {}
  for _, path in ipairs(paths) do
    vim.list_extend(items, collect(path, query, language))
  end
  return items
end

M.kind_name = "file"

return M
