local M = {}

function M.collect(source_ctx)
  local cmd = { "nvim", "--headless", "+lua require('notomo.lib.startup').diagnostic()" }
  return require("thetto.util.job").start(cmd, source_ctx, function(output)
    local x = vim.json.decode(output)
    local relative_path = require("thetto.lib.path").to_relative(x.path, source_ctx.cwd)
    return {
      value = relative_path,
      desc = ("%s:%d %s"):format(relative_path, x.row + 1, x.message:gsub("\n", " ")),
      path = x.path,
      row = x.row + 1,
    }
  end)
end

M.kind_name = "file"

return M
