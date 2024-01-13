local M = {}

function M.collect(source_ctx)
  local cmd = { "go", "list", "-f", "{{.ImportPath}} {{.Dir}}", "std" }
  return require("thetto2.util.job").start(cmd, source_ctx, function(output)
    local package_name, dir = unpack(vim.split(output, " ", { plain = true }))
    return {
      value = package_name,
      path = dir,
    }
  end)
end

M.kind_name = "file/directory"

return M
