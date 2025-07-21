local M = {}

function M.expr()
  local selected = vim.fn.getregionpos(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })[1]
  if not selected then
    return ""
  end
  require("misclib.visual_mode").leave()

  local start_pos = selected[1]
  local end_pos = selected[2]
  local node = vim.treesitter.get_node({ pos = { start_pos[2] - 1, start_pos[3] - 1 } })
  if not node then
    return ""
  end

  while node do
    local start_row, start_col, end_row, end_col = node:range()
    local node_start_row, node_start_col = start_row + 1, start_col + 1
    local node_end_row, node_end_col = end_row + 1, end_col + 1

    if
      (node_start_row > start_pos[2] or (node_start_row == start_pos[2] and node_start_col >= start_pos[3]))
      and (node_end_row < end_pos[2] or (node_end_row == end_pos[2] and node_end_col <= end_pos[3]))
    then
      local parent = node:parent()
      if parent then
        node = parent
      else
        break
      end
    else
      break
    end
  end

  return node:sexpr()
end

return M
