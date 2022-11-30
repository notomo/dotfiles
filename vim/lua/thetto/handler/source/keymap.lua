local M = {}

function M.collect()
  local paths = vim.fn.glob("~/dotfiles/vim/**/*.lua", false, true)
  local keymaps, err = require("listdefined").keymap(paths)
  if err then
    return nil, err
  end
  return vim.tbl_map(function(keymap)
    return {
      path = keymap.path,
      row = keymap.start_row,
      value = require("notomo.treesitter").remove_indent(keymap.text),
    }
  end, keymaps)
end

M.kind_name = "file"

return M
