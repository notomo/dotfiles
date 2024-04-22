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
M.actions = {
  action_open_editor = function(items)
    local item = items[1]
    if not item then
      return
    end
    require("notomo.lib.treesitter.query").open(item.path)
  end,
  default_action = "open_editor",
}

return M
