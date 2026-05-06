local M = {}

function M.collect(source_ctx)
  local bufnr = source_ctx.bufnr
  local filetype = vim.bo[bufnr].filetype

  local ok, snippets = pcall(require, "notomo.lsp.snippet." .. filetype)
  if not ok then
    return {}
  end

  local items = {}
  for name, snippet in pairs(snippets) do
    local body = snippet.body:sub(1, -2)
    items[#items + 1] = {
      value = name,
      body = body,
      original_item = { body = body },
    }
  end
  return items
end

function M.should_collect()
  return false
end

function M.resolve(params, _, offset)
  local window_id = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(window_id)
  local row, column = unpack(vim.api.nvim_win_get_cursor(window_id))
  vim.api.nvim_buf_set_text(bufnr, row - 1, offset - 1, row - 1, column, { "" })
  vim.snippet.expand(params.body)
end

M.kind_name = "word"
M.kind_label = "Snippet"

M.min_trigger_length = 1

return M
