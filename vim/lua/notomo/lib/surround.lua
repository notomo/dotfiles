local M = {}

M._surrounds = {
  {
    key = "p",
    fn = function()
      return { "(", ")" }
    end,
  },
  {
    key = "l",
    fn = function()
      return { "[", "]" }
    end,
  },
  {
    key = "L",
    fn = function()
      return { "[[", "]]" }
    end,
  },
  {
    key = "d",
    fn = function()
      return { "{", "}" }
    end,
  },
  {
    key = "t",
    fn = function()
      return { "<", ">" }
    end,
  },
  {
    key = "w",
    fn = function()
      return { '"', '"' }
    end,
  },
  {
    key = "q",
    fn = function()
      return { "'", "'" }
    end,
  },
  {
    key = "r",
    fn = function()
      return { "%", "%" }
    end,
  },
  {
    key = "o",
    fn = function()
      return { "|", "|" }
    end,
  },
  {
    key = "x",
    fn = function()
      return { "*", "*" }
    end,
  },
  {
    key = "c",
    fn = function()
      return { "```\n", "\n```" }
    end,
  },
  {
    key = "b",
    fn = function()
      return { "`", "`" }
    end,
  },
  {
    key = ",",
    fn = function()
      return { "<div>\n", "\n</div>" }
    end,
  },
  {
    key = "s",
    fn = function()
      return { "<details>\n<summary>Details</summary>\n\n", "\n\n</details>" }
    end,
  },
}

local surround_map = {}
for _, entry in ipairs(M._surrounds) do
  surround_map[entry.key] = entry.fn
end

local function get_pair(char)
  local fn = surround_map[char]
  if not fn then
    return nil
  end
  return fn()
end

local function read_char()
  local char = vim.fn.getcharstr()
  if char == "" or char == "\27" then
    return nil
  end
  return char
end

local function split_pair_for_line(pair)
  local p1 = vim.split(pair[1], "\n", { plain = true })
  local p2 = vim.split(pair[2], "\n", { plain = true })
  local prefix_new = { unpack(p1, 1, #p1 - 1) }
  local suffix_new = { unpack(p2, 2) }
  return prefix_new, p1[#p1], p2[1], suffix_new
end

local function get_region()
  local save_view = vim.fn.winsaveview()

  local best_start = nil
  local best_end = nil
  local best_pair = nil

  for _, entry in ipairs(M._surrounds) do
    local pair = entry.fn()
    local open = pair[1]
    local close = pair[2]
    local open_pat = "\\V" .. open:gsub("\\", "\\\\")
    local close_pat = "\\V" .. close:gsub("\\", "\\\\")

    local start_pos, end_pos
    if open == close then
      start_pos = vim.fn.searchpos(open_pat, "bW")
      vim.fn.winrestview(save_view)
      if start_pos[1] ~= 0 then
        end_pos = vim.fn.searchpos(close_pat, "W")
        vim.fn.winrestview(save_view)
      end
    else
      start_pos = vim.fn.searchpairpos(open_pat, "", close_pat, "bW")
      if start_pos[1] ~= 0 then
        end_pos = vim.fn.searchpairpos(open_pat, "", close_pat, "W")
      end
      vim.fn.winrestview(save_view)
    end

    if start_pos[1] ~= 0 and end_pos and end_pos[1] ~= 0 then
      local is_closer = best_start == nil
        or start_pos[1] > best_start[1]
        or (start_pos[1] == best_start[1] and start_pos[2] > best_start[2])
      if is_closer then
        best_start = start_pos
        best_end = end_pos
        best_pair = pair
      end
    end
  end

  if not (best_pair and best_start and best_end) then
    return vim.fn.getpos("'["), vim.fn.getpos("']"), { "", "" }
  end

  local start_row, start_col = best_start[1], best_start[2]
  local end_row, end_col = best_end[1], best_end[2]
  return { 0, start_row, start_col, 0 }, { 0, end_row, end_col + #best_pair[2] - 1, 0 }, best_pair
end

--- @return [string,string]|nil
local function detect_pair_from_selection(bufnr, op_type, start_pos, end_pos)
  for _, entry in ipairs(M._surrounds) do
    local pair = entry.fn()
    local prefix_len = #pair[1]
    local suffix_len = #pair[2]

    if op_type == "char" then
      local start_row = start_pos[2] - 1
      local start_col = start_pos[3] - 1
      local end_row = end_pos[2] - 1
      local end_col = end_pos[3]
      if end_col >= suffix_len then
        local start_text = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, start_row, start_col + prefix_len, {})
        local end_text = vim.api.nvim_buf_get_text(bufnr, end_row, end_col - suffix_len, end_row, end_col, {})
        if start_text[1] == pair[1] and end_text[1] == pair[2] then
          return pair
        end
      end
    elseif op_type == "line" then
      local prefix_new, prefix_inline, suffix_inline, suffix_new = split_pair_for_line(pair)
      local start_row = start_pos[2] - 1
      local end_row = end_pos[2] - 1
      local first_line = vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1] or ""
      local last_line = vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, false)[1] or ""
      local matched = (#prefix_inline == 0 or first_line:sub(1, #prefix_inline) == prefix_inline)
        and (#suffix_inline == 0 or last_line:sub(-#suffix_inline) == suffix_inline)
      if matched and #prefix_new > 0 then
        local before_start = start_row - #prefix_new
        if before_start < 0 then
          matched = false
        else
          local before_lines = vim.api.nvim_buf_get_lines(bufnr, before_start, before_start + #prefix_new, false)
          matched = vim.deep_equal(before_lines, prefix_new)
        end
      end
      if matched and #suffix_new > 0 then
        local after_end = end_pos[2]
        if after_end + #suffix_new > vim.api.nvim_buf_line_count(bufnr) then
          matched = false
        else
          local after_lines = vim.api.nvim_buf_get_lines(bufnr, after_end, after_end + #suffix_new, false)
          matched = vim.deep_equal(after_lines, suffix_new)
        end
      end
      if matched then
        return pair
      end
    elseif op_type == "block" then
      local start_col = start_pos[3] - 1
      local end_col = end_pos[3]
      local matched = true
      for row = start_pos[2] - 1, end_pos[2] - 1 do
        local start_text = vim.api.nvim_buf_get_text(bufnr, row, start_col, row, start_col + prefix_len, {})
        local end_text = vim.api.nvim_buf_get_text(bufnr, row, end_col - suffix_len, row, end_col, {})
        if start_text[1] ~= pair[1] or end_text[1] ~= pair[2] then
          matched = false
          break
        end
      end
      if matched then
        return pair
      end
    end
  end
  return nil
end

local add_state = {
  fresh = true,
  char = nil,
  end_of_line = false,
}
function M.add_operator(operator_type)
  if operator_type == nil then
    add_state.fresh = true
    add_state.end_of_line = vim.fn.getcurpos()[5] == vim.v.maxcol
    vim.o.operatorfunc = "v:lua.require'notomo.lib.surround'.add_operator"
    return "g@"
  end

  local char
  if add_state.fresh then
    add_state.fresh = false
    char = read_char()
    if not char then
      return
    end
    add_state.char = char
  else
    char = add_state.char
    if not char then
      vim.notify("no surround char in state", vim.log.levels.WARN)
      return
    end
  end

  local pair = get_pair(char)
  if not pair then
    vim.notify("unknown surround: " .. char, vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local start_pos = vim.fn.getpos("'[")
  local end_pos = vim.fn.getpos("']")
  if operator_type == "char" then
    vim.api.nvim_buf_set_text(bufnr, end_pos[2] - 1, end_pos[3], end_pos[2] - 1, end_pos[3], { pair[2] })
    vim.api.nvim_buf_set_text(
      bufnr,
      start_pos[2] - 1,
      start_pos[3] - 1,
      start_pos[2] - 1,
      start_pos[3] - 1,
      { pair[1] }
    )
  elseif operator_type == "line" then
    local prefix_new, prefix_inline, suffix_inline, suffix_new = split_pair_for_line(pair)
    local start_row = start_pos[2] - 1
    local last_row = end_pos[2] - 1
    local last_line = vim.api.nvim_buf_get_lines(bufnr, last_row, last_row + 1, false)[1] or ""
    if #suffix_new > 0 then
      vim.api.nvim_buf_set_lines(bufnr, end_pos[2], end_pos[2], false, suffix_new)
    end
    if #suffix_inline > 0 then
      vim.api.nvim_buf_set_text(bufnr, last_row, #last_line, last_row, #last_line, { suffix_inline })
    end
    if #prefix_new > 0 then
      vim.api.nvim_buf_set_lines(bufnr, start_row, start_row, false, prefix_new)
    end
    if #prefix_inline > 0 then
      vim.api.nvim_buf_set_text(bufnr, start_row, 0, start_row, 0, { prefix_inline })
    end
  elseif operator_type == "block" then
    for row = end_pos[2], start_pos[2], -1 do
      local line_len = #(vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or "")
      local end_col = add_state.end_of_line and line_len or math.min(end_pos[3], line_len)
      local start_col = math.min(start_pos[3] - 1, line_len)
      vim.api.nvim_buf_set_text(bufnr, row - 1, end_col, row - 1, end_col, { pair[2] })
      vim.api.nvim_buf_set_text(bufnr, row - 1, start_col, row - 1, start_col, { pair[1] })
    end
  end
end

local delete_state = {
  fresh = true,
}
function M.delete_operator(operator_type)
  if operator_type == nil then
    delete_state.fresh = true
    vim.o.operatorfunc = "v:lua.require'notomo.lib.surround'.delete_operator"
    return "g@"
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local start_pos ---@type [integer,integer,integer,integer]
  local end_pos ---@type [integer,integer,integer,integer]
  local pair ---@type [string,string]
  if delete_state.fresh then
    delete_state.fresh = false

    start_pos = vim.fn.getpos("'[")
    end_pos = vim.fn.getpos("']")

    local detected = detect_pair_from_selection(bufnr, operator_type, start_pos, end_pos)
    if not detected then
      vim.notify("surround not found in selection", vim.log.levels.WARN)
      return
    end
    pair = detected
  else
    start_pos, end_pos, pair = get_region()
    if #pair[1] == 0 and #pair[2] == 0 then
      vim.notify("surround not found", vim.log.levels.WARN)
      return
    end
  end

  if operator_type == "char" then
    local prefix_len = #pair[1]
    local suffix_len = #pair[2]
    vim.api.nvim_buf_set_text(bufnr, end_pos[2] - 1, end_pos[3] - suffix_len, end_pos[2] - 1, end_pos[3], {})
    vim.api.nvim_buf_set_text(
      bufnr,
      start_pos[2] - 1,
      start_pos[3] - 1,
      start_pos[2] - 1,
      start_pos[3] - 1 + prefix_len,
      {}
    )
  elseif operator_type == "line" then
    local prefix_new, prefix_inline, suffix_inline, suffix_new = split_pair_for_line(pair)
    local start_row = start_pos[2] - 1
    local last_row = end_pos[2] - 1
    local last_line = vim.api.nvim_buf_get_lines(bufnr, last_row, last_row + 1, false)[1] or ""
    local before_start = start_row - #prefix_new
    if #suffix_new > 0 then
      vim.api.nvim_buf_set_lines(bufnr, end_pos[2], end_pos[2] + #suffix_new, false, {})
    end
    if #suffix_inline > 0 then
      vim.api.nvim_buf_set_text(bufnr, last_row, #last_line - #suffix_inline, last_row, #last_line, {})
    end
    if #prefix_new > 0 then
      vim.api.nvim_buf_set_lines(bufnr, before_start, before_start + #prefix_new, false, {})
    end
    if #prefix_inline > 0 then
      vim.api.nvim_buf_set_text(bufnr, before_start, 0, before_start, #prefix_inline, {})
    end
  elseif operator_type == "block" then
    local prefix_len = #pair[1]
    local suffix_len = #pair[2]
    for row = end_pos[2], start_pos[2], -1 do
      vim.api.nvim_buf_set_text(bufnr, row - 1, end_pos[3] - suffix_len, row - 1, end_pos[3], {})
      vim.api.nvim_buf_set_text(bufnr, row - 1, start_pos[3] - 1, row - 1, start_pos[3] - 1 + prefix_len, {})
    end
  end
end

local replace_state = {
  fresh = true,
  new_char = nil,
}
function M.replace_operator(operator_type)
  if operator_type == nil then
    replace_state.fresh = true
    vim.o.operatorfunc = "v:lua.require'notomo.lib.surround'.replace_operator"
    return "g@"
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local start_pos ---@type [integer,integer,integer,integer]
  local end_pos ---@type [integer,integer,integer,integer]
  local old_pair ---@type [string,string]
  local new_pair ---@type [string,string]

  if replace_state.fresh then
    replace_state.fresh = false

    start_pos = vim.fn.getpos("'[")
    end_pos = vim.fn.getpos("']")

    local detected = detect_pair_from_selection(bufnr, operator_type, start_pos, end_pos)
    if not detected then
      vim.notify("surround not found in selection", vim.log.levels.WARN)
      return
    end
    old_pair = detected

    local new_char = read_char()
    if not new_char then
      return
    end

    local new = get_pair(new_char)
    if not new then
      vim.notify("unknown surround: " .. new_char, vim.log.levels.WARN)
      return
    end

    replace_state.new_char = new_char
    new_pair = new
  else
    local new_char = replace_state.new_char
    if not new_char then
      vim.notify("no surround pair in state", vim.log.levels.WARN)
      return
    end

    local new = get_pair(new_char)
    if not new then
      vim.notify("unknown surround: " .. new_char, vim.log.levels.WARN)
      return
    end

    start_pos, end_pos, old_pair = get_region()
    if #old_pair[1] == 0 and #old_pair[2] == 0 then
      vim.notify("surround not found", vim.log.levels.WARN)
      return
    end
    new_pair = new
  end

  if operator_type == "char" then
    local inner_start_col = start_pos[3] - 1 + #old_pair[1]
    local inner_end_col = end_pos[3] - #old_pair[2]
    local inner = vim.api.nvim_buf_get_text(bufnr, start_pos[2] - 1, inner_start_col, end_pos[2] - 1, inner_end_col, {})
    inner[1] = new_pair[1] .. inner[1]
    inner[#inner] = inner[#inner] .. new_pair[2]
    vim.api.nvim_buf_set_text(bufnr, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], inner)
  elseif operator_type == "line" then
    local old_prefix_new, old_prefix_inline, old_suffix_inline, old_suffix_new = split_pair_for_line(old_pair)
    local new_prefix_new, new_prefix_inline, new_suffix_inline, new_suffix_new = split_pair_for_line(new_pair)
    local start_row = start_pos[2] - 1
    local last_row = end_pos[2] - 1
    local last_line = vim.api.nvim_buf_get_lines(bufnr, last_row, last_row + 1, false)[1] or ""
    local old_before_start = start_row - #old_prefix_new
    vim.api.nvim_buf_set_lines(bufnr, end_pos[2], end_pos[2] + #old_suffix_new, false, new_suffix_new)
    vim.api.nvim_buf_set_text(
      bufnr,
      last_row,
      #last_line - #old_suffix_inline,
      last_row,
      #last_line,
      { new_suffix_inline }
    )
    vim.api.nvim_buf_set_lines(bufnr, old_before_start, old_before_start + #old_prefix_new, false, new_prefix_new)
    local new_start_row = old_before_start + #new_prefix_new
    vim.api.nvim_buf_set_text(bufnr, new_start_row, 0, new_start_row, #old_prefix_inline, { new_prefix_inline })
  elseif operator_type == "block" then
    for row = end_pos[2], start_pos[2], -1 do
      local inner_start_col = start_pos[3] - 1 + #old_pair[1]
      local inner_end_col = end_pos[3] - #old_pair[2]
      local inner = vim.api.nvim_buf_get_text(bufnr, row - 1, inner_start_col, row - 1, inner_end_col, {})
      inner[1] = new_pair[1] .. inner[1]
      inner[#inner] = inner[#inner] .. new_pair[2]
      vim.api.nvim_buf_set_text(bufnr, row - 1, start_pos[3] - 1, row - 1, end_pos[3], inner)
    end
  end
end

return M
