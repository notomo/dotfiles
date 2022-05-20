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

function M.highlight(self, bufnr, first_line, items)
  local highlighter = self.highlights:create(bufnr)
  for i, item in ipairs(items) do
    local hl_group = hl_groups[item.severity]
    highlighter:add(hl_group, first_line + i - 1, 0, PREFIX_LENGTH)
  end
end

M.kind_name = "file"
M.sorters = { "row", "numeric:severity" }

return M
