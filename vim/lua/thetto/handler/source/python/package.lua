local M = {}

function M.collect(source_ctx)
  local cmd = { "python", vim.fn.expand("$DOTFILES/vim/lua/thetto/handler/source/python/package.py") }
  return require("thetto.util.job").start(cmd, source_ctx, function(output)
    return {
      value = output,
    }
  end)
end

M.kind_name = "python/package"

return M
