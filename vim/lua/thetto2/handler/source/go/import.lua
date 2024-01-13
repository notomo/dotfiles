local M = {}

function M.collect(source_ctx)
  local cmd = { "go", "list", "-f", [[{{ join .Deps "\n" }}{{"\n"}}{{ join .TestImports "\n" }}]], "./..." }
  return require("thetto2.util.job").run(cmd, source_ctx, function(output)
    return {
      value = output,
    }
  end, {
    to_outputs = function(output)
      local outputs = require("thetto2.util.job.parse").output(output)
      table.sort(outputs, function(a, b)
        return a < b
      end)
      return vim.fn.uniq(outputs)
    end,
  })
end

M.kind_name = "file/directory"

return M
