local M = {}

function M.textobject(capture_name)
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr)
  if not parser then
    return
  end

  local lang = parser:lang()
  local query = vim.treesitter.query.get(lang, "textobjects")
  if not query then
    return
  end

  local target = capture_name:gsub("^@", "")

  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_row, cur_col = cursor[1] - 1, cursor[2]

  local root = parser:parse()[1]:root()

  local containing, containing_size
  local next_after, next_distance
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if query.captures[id] == target then
      local sr, sc, er, ec = node:range()
      local contains = (cur_row > sr or (cur_row == sr and cur_col >= sc))
        and (cur_row < er or (cur_row == er and cur_col < ec))
      if contains then
        local size = (er - sr) * 100000 + (ec - sc)
        if not containing_size or size < containing_size then
          containing, containing_size = { sr, sc, er, ec }, size
        end
      else
        local starts_after = sr > cur_row or (sr == cur_row and sc >= cur_col)
        if starts_after then
          local distance = (sr - cur_row) * 100000 + (sc - cur_col)
          if not next_distance or distance < next_distance then
            next_after, next_distance = { sr, sc, er, ec }, distance
          end
        end
      end
    end
  end

  local best = containing or next_after
  if not best then
    return
  end

  local sr, sc, er, ec = best[1], best[2], best[3], best[4]

  if ec == 0 then
    er = er - 1
    ec = #vim.api.nvim_buf_get_lines(bufnr, er, er + 1, true)[1]
  end

  vim.api.nvim_buf_set_mark(bufnr, "<", sr + 1, sc, {})
  vim.api.nvim_buf_set_mark(bufnr, ">", er + 1, math.max(0, ec - 1), {})
  vim.cmd.normal({ args = { "gv" }, bang = true })
end

return M
