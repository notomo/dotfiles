local M = {}

M.opts = {
  package_name = "",
}

function M.collect(self, source_ctx)
  local package_name = self.opts.package_name
  local cmd = {
    "python",
    vim.fn.expand("~/dotfiles/vim/lua/thetto/handler/source/python/attribute.py"),
    package_name,
  }
  return require("thetto.util").job.start(cmd, source_ctx, function(output)
    local value
    if package_name ~= "" then
      value = ("%s.%s"):format(package_name, output)
    else
      value = output
    end
    return {
      value = value,
    }
  end)
end

M.kind_name = "python/attribute"

return M
