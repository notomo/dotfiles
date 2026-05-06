local vim = vim

local M = {}

vim.api.nvim_create_user_command("Git", function(command)
  local args = command.fargs
  require("notomo.lib.job").run({ "git", unpack(args) })
end, { nargs = "+" })

function M.pull(args)
  local remote = M._remote()
  local branch = M.current_branch()
  if branch == "" then
    require("notomo.lib.message").warn("no specific branch")
    return ""
  end
  local cmd = { "pull", remote, branch, unpack(args or {}) }
  return (":<C-u>Git %s"):format(table.concat(cmd, " "))
end

function M.push()
  local remote = M._remote()
  local branch = M.current_branch()
  if branch == "" then
    require("notomo.lib.message").warn("no specific branch")
    return ""
  end
  return (":<C-u>Git push %s %s"):format(remote, branch)
end

function M.fetch()
  local remote = M._remote()
  return (":<C-u>Git fetch %s"):format(remote)
end

function M.apply()
  local path = vim.api.nvim_buf_get_name(0)
  return (":<C-u>Git apply %s"):format(path)
end

function M.cmd(cmd)
  return (":<C-u>Git %s"):format(table.concat(cmd, " "))
end

function M._remote()
  return "origin"
end

function M.root()
  return vim.fs.root(".", { ".git" })
end

local branch_watchers = {}

function M.branch_component()
  if vim.b.notomo_git_branch then
    return vim.b.notomo_git_branch
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local clear = function()
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    vim.b[bufnr].notomo_git_branch = nil
    vim.schedule(function() -- workaround for highlighter end_col out of range error
      vim.cmd.redrawstatus()
    end)
  end

  local head_file_path = M._head_file_path()
  if not head_file_path then
    return ""
  end

  local branch = M._current_branch(head_file_path)
  local events = vim.tbl_contains({ "kivi-file" }, vim.bo.filetype) and { "BufReadCmd" } or { "BufRead" }
  vim.api.nvim_create_autocmd(events, {
    buf = bufnr,
    callback = function()
      local watcher = branch_watchers[bufnr]
      if watcher then
        watcher:stop()
        watcher:close()
        branch_watchers[bufnr] = nil
      end
      clear()
    end,
    once = true,
  })

  local old_watcher = branch_watchers[bufnr]
  if old_watcher then
    old_watcher:stop()
    old_watcher:close()
  end

  local watcher = vim.uv.new_fs_event()
  if not watcher then
    return branch
  end

  branch_watchers[bufnr] = watcher
  watcher:start(head_file_path, {}, function()
    branch_watchers[bufnr] = nil
    watcher:stop()
    watcher:close()
    vim.schedule(function()
      clear()
    end)
  end)

  vim.b.notomo_git_branch = branch
  return branch
end

function M.current_branch()
  vim.b.notomo_git_branch = nil
  vim.cmd.redrawstatus()

  local head_file_path = M._head_file_path()
  if not head_file_path then
    return ""
  end
  return M._current_branch(head_file_path)
end

function M._current_branch(head_file_path)
  local f = io.open(head_file_path)
  if not f then
    return ""
  end
  local content = vim.trim(f:read("*a"))
  f:close()

  local splitted = vim.split(content, " ", { plain = true })
  if #splitted == 1 then
    return splitted[1]
  end

  local ref = splitted[2]
  local branch = ref:sub(#"refs/heads/" + 1)
  return branch
end

function M._head_file_path()
  local git_root = M.root()
  if not git_root then
    return nil
  end
  return vim.fs.joinpath(git_root, ".git/HEAD")
end

function M.yank_commit_message(revision)
  local message = vim.fn.systemlist({ "git", "log", "--format=%B", "-n", "1", revision })[1]
  require("notomo.lib.edit").yank(message)
end

local function _selection_diff(rev_spec)
  local v_row = vim.fn.getpos("v")[2]
  local cur_row = vim.fn.getpos(".")[2]
  require("misclib.visual_mode").leave()
  local sel_start = math.min(v_row, cur_row)
  local sel_end = math.max(v_row, cur_row)

  local git_root = M.root()
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

function M.reset_selection()
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

function M.stage_selection()
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

local SIGN_TEXT = { added = "┃", changed = "┃", deleted = "━" }
local SIGN_HL = {
  added = "@diff.plus",
  changed = "@diff.delta",
  deleted = "@diff.minus",
}

local decorator_ns = vim.api.nvim_create_namespace("notomo_git_sign")
local decorator_state = {}

local function _resolve_target(bufnr)
  local buf_name = vim.api.nvim_buf_get_name(bufnr)
  if buf_name == "" then
    return nil
  end
  local git_root = vim.fs.root(bufnr, ".git")
  if not git_root then
    return nil
  end
  local rel_path = vim.fs.relpath(git_root, vim.fs.normalize(buf_name))
  if not rel_path then
    return nil
  end
  if rel_path == ".git" or vim.startswith(rel_path, ".git/") then
    return nil
  end
  return git_root, rel_path
end

local function _compute_line_kinds(bufnr)
  local git_root, rel_path = _resolve_target(bufnr)
  if not git_root then
    return {}
  end

  local source_lines = {}
  local result = vim.system({ "git", "-C", git_root, "show", "HEAD:" .. rel_path }):wait()
  if result.code == 0 then
    source_lines = vim.split(result.stdout:gsub("\n$", ""), "\n", { plain = true })
  end

  local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local source_text = table.concat(source_lines, "\n") .. "\n"
  local current_text = table.concat(current_lines, "\n") .. "\n"

  local hunks = vim.text.diff(source_text, current_text, { result_type = "indices" }) --[[@as integer[][] ]]
  hunks = hunks or {}

  local line_kinds = {}
  for _, h in ipairs(hunks) do
    local _, count_a, start_b, count_b = h[1], h[2], h[3], h[4]
    if count_a == 0 and count_b > 0 then
      for r = start_b, start_b + count_b - 1 do
        line_kinds[r - 1] = "added"
      end
    elseif count_a > 0 and count_b == 0 then
      local row = start_b == 0 and 0 or (start_b - 1)
      line_kinds[row] = "deleted"
    else
      for r = start_b, start_b + count_b - 1 do
        line_kinds[r - 1] = "changed"
      end
    end
  end
  return line_kinds
end

local function _apply_extmarks(bufnr, line_kinds, old_extmarks)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return old_extmarks
  end

  local new_extmarks = {}
  for row, kind in pairs(line_kinds) do
    local opts = {
      sign_text = SIGN_TEXT[kind],
      sign_hl_group = SIGN_HL[kind],
      priority = 10,
    }
    local id = old_extmarks[row]
    if id then
      opts.id = id
      old_extmarks[row] = nil
    end
    new_extmarks[row] = vim.api.nvim_buf_set_extmark(bufnr, decorator_ns, row, 0, opts)
  end

  for _, id in pairs(old_extmarks) do
    pcall(vim.api.nvim_buf_del_extmark, bufnr, decorator_ns, id)
  end
  return new_extmarks
end

local function _start_watcher(bufnr, on_change)
  local git_root = vim.fs.root(bufnr, ".git")
  if not git_root then
    return nil
  end

  local watchers = {}
  local function add(path, names)
    local w = vim.uv.new_fs_event()
    if not w then
      return
    end
    local ok = pcall(function()
      w:start(path, {}, function(_, filename)
        if not names[filename] then
          return
        end
        vim.schedule(on_change)
      end)
    end)
    if not ok then
      w:close()
      return
    end
    table.insert(watchers, w)
  end

  add(vim.fs.joinpath(git_root, ".git"), { index = true, HEAD = true })
  add(vim.fs.joinpath(git_root, ".git/logs"), { HEAD = true })

  if #watchers == 0 then
    return nil
  end
  return watchers
end

local function _stop_watcher(watchers)
  if not watchers then
    return
  end
  for _, w in ipairs(watchers) do
    w:stop()
    w:close()
  end
end

local function _cleanup(bufnr)
  local entry = decorator_state[bufnr]
  if entry then
    _stop_watcher(entry.watcher)
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_clear_namespace(bufnr, decorator_ns, 0, -1)
    end
  end

  pcall(vim.api.nvim_del_augroup_by_name, ("notomo.git.decorator.%d"):format(bufnr))
  decorator_state[bufnr] = nil
end

function M.cleanup_decorators()
  for bufnr in pairs(decorator_state) do
    _cleanup(bufnr)
  end
end

function M.setup_decorator(bufnr)
  if decorator_state[bufnr] then
    return
  end
  if not _resolve_target(bufnr) then
    return
  end
  local entry = {
    line_kinds = {},
    extmarks = {},
    watcher = nil,
  }
  decorator_state[bufnr] = entry

  local refresh = require("misclib.debounce").wrap(
    50,
    vim.schedule_wrap(function()
      local current = decorator_state[bufnr]
      if not current or not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      current.line_kinds = _compute_line_kinds(bufnr)
      current.extmarks = _apply_extmarks(bufnr, current.line_kinds, current.extmarks)
    end)
  )
  local on_index_change = function()
    if vim.api.nvim_buf_is_valid(bufnr) then
      pcall(vim.cmd.checktime, bufnr)
    end
    refresh()
  end

  refresh()

  vim.api.nvim_buf_attach(bufnr, false, {
    on_lines = function()
      if not decorator_state[bufnr] then
        return true
      end
      refresh()
    end,
    on_reload = function()
      if not decorator_state[bufnr] then
        return
      end
      refresh()
    end,
    on_detach = function()
      _cleanup(bufnr)
    end,
  })

  local augroup = vim.api.nvim_create_augroup(("notomo.git.decorator.%d"):format(bufnr), {})

  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = augroup,
    buffer = bufnr,
    callback = function()
      local current = decorator_state[bufnr]
      if not current or current.watcher then
        return
      end
      current.watcher = _start_watcher(bufnr, on_index_change)
    end,
  })
  vim.api.nvim_create_autocmd({ "WinClosed" }, {
    group = augroup,
    callback = function(args)
      local closing_winid = tonumber(args.match)
      if not closing_winid or not vim.api.nvim_win_is_valid(closing_winid) then
        return
      end
      if vim.api.nvim_win_get_buf(closing_winid) ~= bufnr then
        return
      end
      if #vim.fn.win_findbuf(bufnr) > 1 then
        return
      end
      local current = decorator_state[bufnr]
      if not current then
        return
      end
      _stop_watcher(current.watcher)
      current.watcher = nil
    end,
  })
  vim.api.nvim_create_autocmd({ "BufWipeout" }, {
    group = augroup,
    buffer = bufnr,
    callback = function()
      _cleanup(bufnr)
    end,
  })

  if vim.fn.win_findbuf(bufnr)[1] then
    entry.watcher = _start_watcher(bufnr, on_index_change)
  end
end

return M
