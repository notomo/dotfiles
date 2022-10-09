local M = {}

function M.collect(source_ctx)
  local marks = require("termnavi").list()
  return vim.tbl_map(function(mark)
    return {
      value = tostring(mark.id),
      row = mark.row,
      bufnr = source_ctx.bufnr,
    }
  end, marks)
end

M.kind_name = "position"

return M
