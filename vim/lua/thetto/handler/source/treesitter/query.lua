local M = {}

function M.collect()
  local pattern = "queries/**/*.scm"
  local paths = vim.api.nvim_get_runtime_file(pattern, true)
  return vim.tbl_map(function(path)
    return {
      value = path,
      path = path,
    }
  end, paths)
end

M.kind_name = "file"
M.default_action = "open_editor"
M.actions = {
  action_open_editor = function(items)
    local item = items[1]
    if not item then
      return
    end
    require("notomo.treesitter.query").open(item.path)
  end,
}

return M
