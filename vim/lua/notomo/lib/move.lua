local M = {}

local function move_cursor(row, col)
  vim.api.nvim_win_set_cursor(0, { row, col })
end

local function get_motion_pos(key)
  local save = vim.api.nvim_win_get_cursor(0)
  vim.cmd.normal({ args = { key }, bang = true })
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, save)
  if pos[1] == save[1] and pos[2] == save[2] then
    return nil
  end
  return pos
end

local function searchpos_result(pattern, flags)
  local raw = vim.fn.searchpos(pattern, flags)
  if raw[1] == 0 then
    return nil
  end
  return { raw[1], raw[2] - 1 }
end

local function pos_before(a, b)
  return a[1] < b[1] or (a[1] == b[1] and a[2] < b[2])
end

local function is_word_char(pos)
  local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], true)[1]
  local byte = line:sub(pos[2] + 1, pos[2] + 1)
  return byte:match("[0-9A-Za-z_]") ~= nil
end

function M.w(opts)
  opts = opts or {}
  local fb = get_motion_pos("w")
  local effective_fb = (fb and is_word_char(fb)) and fb or nil
  if opts.pattern then
    local pat = searchpos_result(opts.pattern, "Wn")
    if pat and (opts.bound == false or effective_fb == nil or pos_before(pat, effective_fb)) then
      move_cursor(pat[1], pat[2])
      return
    end
  end
  if fb then
    move_cursor(fb[1], fb[2])
  end
end

function M.b(opts)
  opts = opts or {}
  local fb = get_motion_pos("b")
  local effective_fb = (fb and is_word_char(fb)) and fb or nil
  if opts.pattern then
    local pat = searchpos_result(opts.pattern, "bWn")
    if pat and (opts.bound == false or effective_fb == nil or pos_before(effective_fb, pat)) then
      move_cursor(pat[1], pat[2])
      return
    end
  end
  if fb then
    move_cursor(fb[1], fb[2])
  end
end

function M.e(opts)
  opts = opts or {}
  local fb = get_motion_pos("e")
  local is_op = vim.fn.mode(1):sub(1, 2) == "no"
  if opts.pattern then
    local pat = searchpos_result(opts.pattern, "Wen")
    if pat and (opts.bound == false or fb == nil or pos_before(pat, fb)) then
      move_cursor(pat[1], pat[2] + (is_op and 1 or 0))
      return
    end
  end
  if fb then
    move_cursor(fb[1], fb[2] + (is_op and 1 or 0))
  end
end

return M
