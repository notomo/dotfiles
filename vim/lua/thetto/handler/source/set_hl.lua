local M = {}

function M.collect()
  local paths = vim.fn.glob("~/dotfiles/vim/**/*.lua", false, true)
  local highlights, err = require("listdefined").highlight(paths)
  if err then
    return nil, err
  end
  return vim.tbl_map(function(highlight)
    return {
      path = highlight.path,
      row = highlight.start_row,
      value = require("notomo.treesitter").remove_indent(highlight.text),
    }
  end, highlights)
end

M.kind_name = "file"

return M
