local M = {}

M.opts = {
  paths = {},
}

function M.collect(source_ctx)
  local tabpage = vim.api.nvim_win_get_tabpage(source_ctx.window_id)
  local query_bufnr = vim
    .iter(vim.api.nvim_tabpage_list_wins(tabpage))
    :map(function(window_id)
      return vim.api.nvim_win_get_buf(window_id)
    end)
    :find(function(bufnr)
      if vim.bo[bufnr].filetype ~= "query" then
        return nil
      end
      local name = vim.api.nvim_buf_get_name(bufnr)
      if not vim.endswith(name, ".scm") then
        return nil
      end
      return bufnr
    end)
  if not query_bufnr then
    return {}
  end

  local lines = vim.api.nvim_buf_get_lines(query_bufnr, 0, -1, false)
  local query_text = table.concat(lines, "\n")
  return vim
    .iter(require("listdefined").search(source_ctx.opts.paths, query_text))
    :map(function(e)
      return {
        path = e.path,
        row = e.start_row,
        value = e.text,
      }
    end)
    :totable()
end

M.kind_name = "file"

return M
