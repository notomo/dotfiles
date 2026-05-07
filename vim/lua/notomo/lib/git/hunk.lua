local M = {}

local function _selection_diff(rev_spec)
  local v_row = vim.fn.getpos("v")[2]
  local cur_row = vim.fn.getpos(".")[2]
  require("misclib.visual_mode").leave()
  local sel_start = math.min(v_row, cur_row)
  local sel_end = math.max(v_row, cur_row)

  local git_root = require("notomo.lib.git.repository").root()
  if not git_root then
    require("notomo.lib.message").warn("not a git repository")
    return nil
  end

  local full_path = vim.fs.normalize(vim.api.nvim_buf_get_name(0))
  local rel_path = vim.fs.relpath(git_root, full_path)
  if not rel_path then
    require("notomo.lib.message").warn("not under git root")
    return nil
  end

  local result = vim.system({ "git", "-C", git_root, "show", rev_spec .. ":" .. rel_path }):wait()
  if result.code ~= 0 then
    require("notomo.lib.message").warn(vim.trim(result.stderr or ""))
    return nil
  end

  local source_lines = vim.split(result.stdout:gsub("\n$", ""), "\n", { plain = true })
  local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local source_text = table.concat(source_lines, "\n") .. "\n"
  local current_text = table.concat(current_lines, "\n") .. "\n"

  local hunks = vim.text.diff(source_text, current_text, { result_type = "indices" }) --[[@as integer[][] ]]
  hunks = hunks or {}

  return {
    sel_start = sel_start,
    sel_end = sel_end,
    git_root = git_root,
    rel_path = rel_path,
    source_lines = source_lines,
    current_lines = current_lines,
    hunks = hunks,
  }
end

local function _hunk_overlaps_selection(hunk, sel_start, sel_end)
  local start_b, count_b = hunk[3], hunk[4]
  if count_b == 0 then
    return start_b + 1 >= sel_start and start_b <= sel_end
  end
  return not (start_b + count_b - 1 < sel_start or start_b > sel_end)
end

function M.reset()
  local ctx = _selection_diff("HEAD")
  if not ctx then
    return
  end

  for i = #ctx.hunks, 1, -1 do
    local h = ctx.hunks[i]
    if _hunk_overlaps_selection(h, ctx.sel_start, ctx.sel_end) then
      local start_a, count_a, start_b, count_b = h[1], h[2], h[3], h[4]
      local replacement = {}
      for j = start_a, start_a + count_a - 1 do
        table.insert(replacement, ctx.source_lines[j])
      end
      local set_first = count_b == 0 and start_b or (start_b - 1)
      local set_last = count_b == 0 and start_b or (start_b - 1 + count_b)
      vim.api.nvim_buf_set_lines(0, set_first, set_last, false, replacement)
    end
  end
end

function M.stage()
  local ctx = _selection_diff(":")
  if not ctx then
    return
  end
  if #ctx.hunks == 0 then
    return
  end

  local new_index_lines = {}
  local pos = 1
  for _, h in ipairs(ctx.hunks) do
    local start_a, count_a, start_b, count_b = h[1], h[2], h[3], h[4]
    local hunk_a_first = count_a == 0 and (start_a + 1) or start_a
    for j = pos, hunk_a_first - 1 do
      table.insert(new_index_lines, ctx.source_lines[j])
    end
    if _hunk_overlaps_selection(h, ctx.sel_start, ctx.sel_end) then
      for j = start_b, start_b + count_b - 1 do
        table.insert(new_index_lines, ctx.current_lines[j])
      end
    else
      for j = start_a, start_a + count_a - 1 do
        table.insert(new_index_lines, ctx.source_lines[j])
      end
    end
    pos = count_a == 0 and (start_a + 1) or (start_a + count_a)
  end
  for j = pos, #ctx.source_lines do
    table.insert(new_index_lines, ctx.source_lines[j])
  end

  local new_content = table.concat(new_index_lines, "\n")
  if #new_index_lines > 0 then
    new_content = new_content .. "\n"
  end

  local hash_result = vim
    .system({
      "git",
      "-C",
      ctx.git_root,
      "hash-object",
      "-w",
      "--path=" .. ctx.rel_path,
      "--stdin",
    }, { stdin = new_content })
    :wait()
  if hash_result.code ~= 0 then
    return require("notomo.lib.message").warn(vim.trim(hash_result.stderr or ""))
  end
  local sha = vim.trim(hash_result.stdout)

  local ls_result = vim.system({ "git", "-C", ctx.git_root, "ls-files", "-s", "--", ctx.rel_path }):wait()
  local mode = "100644"
  if ls_result.code == 0 and ls_result.stdout ~= "" then
    mode = vim.split(vim.trim(ls_result.stdout), " ", { plain = true })[1]
  end

  local update_result = vim
    .system({
      "git",
      "-C",
      ctx.git_root,
      "update-index",
      "--add",
      "--cacheinfo",
      ("%s,%s,%s"):format(mode, sha, ctx.rel_path),
    })
    :wait()
  if update_result.code ~= 0 then
    return require("notomo.lib.message").warn(vim.trim(update_result.stderr or ""))
  end
end

return M
