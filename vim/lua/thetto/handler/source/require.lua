local M = {}

function M.collect()
  return vim
    .iter(require("requireall").list())
    :map(function(e)
      return vim
        .iter(e.matches)
        :map(function(match)
          local value = vim.treesitter.get_node_text(match.node, e.source)
          local start_row, start_col, end_row, end_col = match.node:range()
          return {
            path = e.path,
            value = value,
            row = start_row + 1,
            column = start_col,
            end_row = end_row,
            end_column = end_col,
          }
        end)
        :totable()
    end)
    :flatten()
    :totable()
end

M.kind_name = "file"

return M
