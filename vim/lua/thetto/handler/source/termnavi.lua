local M = {}

function M.collect(source_ctx)
  return vim
    .iter(require("termnavi").list())
    :map(function(mark)
      local lines = vim.api.nvim_buf_get_lines(source_ctx.bufnr, mark.row, mark.end_row, false)
      local value = table.concat(lines, "")
      return {
        value = value,
        row = mark.row,
        bufnr = source_ctx.bufnr,
      }
    end)
    :totable()
end

M.kind_name = "vim/position"

return M
