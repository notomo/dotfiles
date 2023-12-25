local M = {}

function M.yank()
  local query = vim.treesitter.query.parse(
    "terraform",
    [[
(block 
  (identifier) @identifier (#any-of? @identifier "resource" "data" "variable")
  (string_lit
    (quoted_template_start)
    (template_literal) @parent_name
    (quoted_template_end)
  )
  (string_lit
    (quoted_template_start)
    (template_literal) @child_name
    (quoted_template_end)
  )?
)
]]
  )

  local base_node = vim.treesitter.get_node({})
  local block = require("notomo.lib.treesitter").find_root_ancestor(base_node, "block", true)
  if not block then
    return
  end

  local prefix_map = {
    data = "data",
    locals = "local",
    variable = "var",
  }
  for _, match in query:iter_matches(block, 0, 0, -1) do
    local extracted = require("misclib.treesitter").get_captures(match, query, function(tbl, key, node)
      tbl[key] = vim.treesitter.get_node_text(node, 0)
    end)

    local elements = {}
    local prefix = prefix_map[extracted.identifier]
    if prefix then
      table.insert(elements, prefix)
    end
    table.insert(elements, extracted.parent_name)
    if extracted.child_name then
      table.insert(elements, extracted.child_name)
    end

    require("notomo.lib.edit").yank(table.concat(elements, "."))
    return
  end
end

function M.go_to_prev_resouce()
  local base_node = vim.treesitter.get_node({})
  -- TODO: if root

  local prev_resource = require("notomo.lib.treesitter").find_root_ancestor(base_node, "block", true)
  if not prev_resource then
    return
  end

  local current_row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local row, column = prev_resource:start()
  if row == current_row then
    prev_resource = prev_resource:prev_sibling() or prev_resource
  end
  row, column = prev_resource:start()

  require("misclib.window").jump(0, row + 1, column)
end

function M.go_to_next_resouce()
  local base_node = vim.treesitter.get_node({})
  -- TODO: if root

  local prev_resouce = require("notomo.lib.treesitter").find_root_ancestor(base_node, "block", true)
  if not prev_resouce then
    return
  end

  local next_resouce = prev_resouce:next_sibling()
  if not next_resouce then
    return
  end

  local row, column = next_resouce:start()
  require("misclib.window").jump(0, row + 1, column)
end

return M
