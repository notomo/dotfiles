local M = {}

local group = vim.api.nvim_create_augroup("notomo.treesitter.query", {})
local ns = vim.api.nvim_create_namespace("notomo.treesitter.query")

function M.open(query_path)
  local target_bufnr = vim.api.nvim_get_current_buf()
  vim.cmd.split({ args = { query_path }, mods = { split = "belowright" } })
  local query_bufnr = vim.api.nvim_get_current_buf()

  local decorator = require("misclib.decorator").new(ns, target_bufnr, false)

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = group,
    buffer = target_bufnr,
    callback = function()
      M._update(decorator, target_bufnr, query_bufnr)
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = group,
    buffer = query_bufnr,
    callback = function()
      M._update(decorator, target_bufnr, query_bufnr)
    end,
  })
  vim.api.nvim_create_autocmd({ "WinClosed", "BufHidden" }, {
    group = group,
    buffer = query_bufnr,
    callback = function()
      M._clear(decorator, target_bufnr, query_bufnr)
    end,
  })

  M._update(decorator, target_bufnr, query_bufnr)

  return nil
end

function M._update(decorator, target_bufnr, query_bufnr)
  if not vim.api.nvim_buf_is_valid(target_bufnr) or not vim.api.nvim_buf_is_valid(query_bufnr) then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(query_bufnr, 0, -1, false)
  local query_str = table.concat(lines, "\n")

  local language = vim.bo[target_bufnr].filetype
  local query = vim.treesitter.query.parse_query(language, query_str)
  local root = require("misclib.treesitter").get_first_tree_root(target_bufnr, language)

  decorator:clear()

  for _, node in query:iter_captures(root, target_bufnr, 0, -1) do
    local start_row, range_start_col, end_row, range_end_col = node:range()
    for row = start_row, end_row do
      local start_col = 0
      local end_col = -1
      if row == start_row then
        start_col = range_start_col
      end
      if row == end_row then
        end_col = range_end_col
      end
      decorator:highlight("Todo", row, start_col, end_col, { priority = 50 })
    end
  end
end

function M._clear(decorator, target_bufnr, query_bufnr)
  decorator:clear()
  vim.api.nvim_clear_autocmds({ buffer = target_bufnr, group = group })
  vim.api.nvim_clear_autocmds({ buffer = query_bufnr, group = group })
end

return M
