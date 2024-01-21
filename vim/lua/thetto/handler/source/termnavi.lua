local M = {}

function M.collect(source_ctx)
  local marks = require("termnavi").list()
  return vim.tbl_map(function(mark)
    local lines = vim.api.nvim_buf_get_lines(source_ctx.bufnr, mark.row, mark.end_row, false)
    local value = table.concat(lines, "")
    return {
      value = value,
      row = mark.row,
      bufnr = source_ctx.bufnr,
    }
  end, marks)
end

M.kind_name = "vim/position"

return M
