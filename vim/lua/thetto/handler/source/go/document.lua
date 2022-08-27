local M = {}

M.opts = {
  package_name = "builtin",
}

function M.collect(self, source_ctx)
  local cmd = { "go", "doc", "-short", self.opts.package_name }
  return require("thetto.util.job").start(cmd, source_ctx, function(output)
    local reserved_word, method_or_field = output:match([[%s*(%S+)%s([a-zA-Z][a-zA-Z0-9_]*)]])
    return {
      value = output,
      package_name = self.opts.package_name,
      method_or_field = method_or_field,
      reserved_word = reserved_word,
    }
  end)
end

M.kind_name = "go/document"

return M
