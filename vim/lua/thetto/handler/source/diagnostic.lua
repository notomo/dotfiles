local M = {}

local PREFIX = "■ "
local PREFIX_LENGTH = #PREFIX

function M.collect()
  local items = {}
  for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
    local path = vim.api.nvim_buf_get_name(diagnostic.bufnr)
    local desc = PREFIX .. diagnostic.message
    table.insert(items, {
      value = diagnostic.message,
      desc = desc,
      row = diagnostic.lnum + 1,
      path = path,
      severity = diagnostic.severity,
      column_offsets = { value = PREFIX_LENGTH },
    })
  end
  return items
end

local hl_groups = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticError",
  [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticHint",
}

M.highlight = require("thetto.util").highlight.columns({
  {
    group = function(item)
      return hl_groups[item.severity]
    end,
    end_column = PREFIX_LENGTH,
  },
})

M.kind_name = "file"
M.sorters = { "row", "numeric:severity" }

return M
