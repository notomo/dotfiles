local M = {}

function M.collect(_, source_ctx)
  local cmd = { "go", "list", "-f", "{{.ImportPath}} {{.Dir}}", "std" }
  return require("thetto.util").job.run(cmd, source_ctx, function(output)
    local package_name, dir = unpack(vim.split(output, " ", true))
    return {
      value = package_name,
      path = dir,
    }
  end)
end

M.kind_name = "go/package"

return M
