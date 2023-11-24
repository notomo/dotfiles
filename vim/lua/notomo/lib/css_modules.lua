local M = {}

function M.cursor_on_jsx_css_module()
  local base_node = vim.treesitter.get_node()
  if base_node:type() ~= "property_identifier" then
    return false
  end

  if not require("notomo.lib.treesitter").find_ancestor(base_node, "jsx_expression") then
    return false
  end

  local jsx_attribute_node = require("notomo.lib.treesitter").find_ancestor(base_node, "jsx_attribute")
  if not jsx_attribute_node then
    return false
  end

  local property_identifier = jsx_attribute_node:child(0)
  local property_name = vim.treesitter.get_node_text(property_identifier, 0)
  return property_name == "className"
end

return M
