local M = {}

function M.collect()
  local pattern = "queries/**/*.scm"
  local paths = vim.api.nvim_get_runtime_file(pattern, true)
  return vim
    .iter(paths)
    :map(function(path)
      return {
        value = path,
        path = path,
      }
    end)
    :totable()
end

M.kind_name = "file"

return M
