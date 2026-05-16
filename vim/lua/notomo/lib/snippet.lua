local M = {}

function M.get_snippets(bufnr)
  local filetype = vim.bo[bufnr].filetype
  local ok, snippets = pcall(require, "notomo.lsp.snippet." .. filetype)
  if not ok then
    return {}
  end
  return snippets
end

-- Resolve the keyword around the cursor by scanning the line text.
-- vim.fn.expand("<cword>") is unreliable in insert mode since the cursor
-- sits just past the typed word, so derive it from the byte column instead.
local function get_cword(window_id)
  local column = vim.api.nvim_win_get_cursor(window_id)[2]
  local line = vim.api.nvim_get_current_line()

  local left = column
  while left >= 1 and line:sub(left, left):match("[%w_]") do
    left = left - 1
  end
  local right = column
  while right < #line and line:sub(right + 1, right + 1):match("[%w_]") do
    right = right + 1
  end

  return line:sub(left + 1, right), left + 1
end

function M.can_expand()
  local cword = get_cword(vim.api.nvim_get_current_win())
  if cword == "" then
    return false
  end

  local snippets = M.get_snippets(vim.api.nvim_get_current_buf())
  return snippets[cword] ~= nil
end

function M.expand(body, offset)
  local window_id = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(window_id)
  local row, column = unpack(vim.api.nvim_win_get_cursor(window_id))
  vim.api.nvim_buf_set_text(bufnr, row - 1, offset - 1, row - 1, column, { "" })
  vim.snippet.expand(body)
end

function M.expand_cword()
  local window_id = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(window_id)
  local cword, offset = get_cword(window_id)
  if cword == "" then
    return false
  end

  local snippet = M.get_snippets(bufnr)[cword]
  if not snippet then
    return false
  end

  local body = snippet.body:sub(-1) == "\n" and snippet.body:sub(1, -2) or snippet.body
  M.expand(body, offset)
  return true
end

return M
