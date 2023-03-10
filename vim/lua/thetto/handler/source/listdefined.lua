local M = {}

M.opts = {
  name = "autocmd",
}

function M.collect(source_ctx)
  local paths = vim.fn.glob("$DOTFILES/vim/**/*.lua", false, true)
  local elements, err = require("listdefined")[source_ctx.opts.name](paths)
  if err then
    return nil, err
  end
  return vim.tbl_map(function(e)
    return {
      path = e.path,
      row = e.start_row,
      value = require("notomo.treesitter").remove_indent(e.text),
    }
  end, elements)
end

M.kind_name = "file"

return M
