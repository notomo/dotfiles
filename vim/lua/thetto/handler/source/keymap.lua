local M = {}

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
      ["keymap"] = function(tbl, tsnode)
        tbl.keymap = tsnode
      end,
      ["keymap.mode"] = function(tbl, tsnode)
        tbl.mode = tsnode
      end,
      ["keymap.lhs"] = function(tbl, tsnode)
        tbl.lhs = tsnode
      end,
      ["keymap.rhs"] = function(tbl, tsnode)
        tbl.rhs = tsnode
      end,
      ["keymap.opts"] = function(tbl, tsnode)
        tbl.opts = tsnode
      end,
    })
    local row = captured.keymap:start()
    local mode = require("notomo.treesitter").remove_indent(vim.treesitter.get_node_text(captured.mode, str))
    local lhs = require("notomo.treesitter").remove_indent(vim.treesitter.get_node_text(captured.lhs, str))
    local rhs = require("notomo.treesitter").remove_indent(vim.treesitter.get_node_text(captured.rhs, str))
    local texts = { mode, lhs, rhs }
    local opts
    if captured.opts then
      opts = require("notomo.treesitter").remove_indent(vim.treesitter.get_node_text(captured.opts, str))
      table.insert(texts, opts)
    end
    local text = table.concat(texts, " ")
    table.insert(items, {
      value = text,
      path = path,
      row = row + 1,
      keymap = {
        mode = mode,
        lhs = lhs,
        rhs = rhs,
        opts = opts,
      },
    })
  end
  return items
end

function M.collect()
  local language = "lua"
  if not vim.treesitter.language.require_language(language, nil, true) then
    return nil, ("not found tree-sitter parser for `%s`"):format(language)
  end

  local paths = vim.fn.glob("~/dotfiles/vim/**/*.lua", false, true)
  local query = vim.treesitter.parse_query(
    "lua",
    [[
(
  (function_call
    name: (_) @keymap (#match? @keymap "^vim.keymap.set$")
    arguments: (arguments
      .
      (_) @keymap.mode
      .
      (_) @keymap.lhs
      .
      (_) @keymap.rhs
      .
      (_)? @keymap.opts
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
