local M = {}

function M.collect(_, source_ctx)
  local cmd = { "brew", "list", "-1" }
  return require("thetto.util").job.run(cmd, source_ctx, function(output)
    return { value = output }
  end)
end

M.kind_name = "word"

return M
