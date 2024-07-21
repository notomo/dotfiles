local M = {}

function M.collect()
  local roles_dir = vim.fn.expand("$DOTFILES/ansible/roles")
  return vim
    .iter(vim.fn.readdir(roles_dir))
    :map(function(path)
      return {
        value = path,
        path = vim.fs.joinpath(roles_dir, path),
      }
    end)
    :totable()
end

M.kind_name = "ansible/role"

return M
