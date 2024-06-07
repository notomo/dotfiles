local M = {}

M.opts = {
  name = "autocmd",
}

function M.collect(source_ctx)
  local paths = vim.fn.glob("$DOTFILES/vim/**/*.lua", false, true)
  local elements = require("listdefined")[source_ctx.opts.name](paths)
  return vim
    .iter(elements)
    :map(function(e)
      return {
        path = e.path,
        row = e.start_row,
        value = require("notomo.lib.treesitter").remove_indent(e.text),
      }
    end)
    :totable()
end

M.kind_name = "file"

return M
