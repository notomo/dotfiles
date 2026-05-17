local M = {}

local SIGN_TEXT = { added = "┃", changed = "┃", deleted = "━" }
local SIGN_HL = {
  added = "@diff.plus",
  changed = "@diff.delta",
  deleted = "@diff.minus",
}

local ns = vim.api.nvim_create_namespace("notomo.lib.git.decorator")
local state = {}
local attach_ids = {}
local _next_attach_id = 0
local watchers_by_root = {}

local function _resolve_target(bufnr)
  if vim.bo[bufnr].buftype ~= "" then
    return nil
  end
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
  else
    local ignored = vim.system({ "git", "-C", git_root, "check-ignore", "-q", rel_path }):wait()
    if ignored.code == 0 then
      return {}
    end
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
    new_extmarks[row] = vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, opts)
  end

  for _, id in pairs(old_extmarks) do
    pcall(vim.api.nvim_buf_del_extmark, bufnr, ns, id)
  end
  return new_extmarks
end

local function _start_watchers_for_root(git_root, on_change)
  local handles = {}
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
        on_change()
      end)
    end)
    if not ok then
      w:close()
      return
    end
    table.insert(handles, w)
  end

  add(vim.fs.joinpath(git_root, ".git"), { index = true, HEAD = true })
  add(vim.fs.joinpath(git_root, ".git/logs"), { HEAD = true })

  return handles
end

local function _subscribe(git_root, bufnr, refresh)
  local entry = watchers_by_root[git_root]
  if not entry then
    entry = { handles = {}, subscribers = {} }
    watchers_by_root[git_root] = entry
    entry.handles = _start_watchers_for_root(git_root, function()
      for _, fn in pairs(entry.subscribers) do
        fn(true)
      end
    end)
  end
  entry.subscribers[bufnr] = refresh
end

local function _unsubscribe(git_root, bufnr)
  local entry = watchers_by_root[git_root]
  if not entry then
    return
  end
  entry.subscribers[bufnr] = nil
  if next(entry.subscribers) == nil then
    for _, w in ipairs(entry.handles) do
      w:stop()
      w:close()
    end
    watchers_by_root[git_root] = nil
  end
end

local function _cleanup(bufnr)
  local entry = state[bufnr]
  if entry then
    if entry.git_root then
      _unsubscribe(entry.git_root, bufnr)
    end
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    end
    if entry.attach_id then
      attach_ids[entry.attach_id] = nil
    end
  end

  pcall(vim.api.nvim_del_augroup_by_name, ("notomo.lib.git.decorator.%d"):format(bufnr))
  state[bufnr] = nil
end

function M.cleanup()
  for bufnr in pairs(state) do
    _cleanup(bufnr)
  end
end

function M.setup(bufnr)
  if state[bufnr] then
    return
  end
  local git_root = _resolve_target(bufnr)
  if not git_root then
    return
  end

  _next_attach_id = _next_attach_id + 1
  local id = _next_attach_id
  attach_ids[id] = bufnr

  local entry = {
    line_kinds = {},
    extmarks = {},
    git_root = git_root,
    attach_id = id,
  }
  state[bufnr] = entry

  local refresh = require("misclib.debounce").wrap(
    200,
    vim.schedule_wrap(function(with_checktime)
      local current = state[bufnr]
      if not current or not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      if vim.fn.win_findbuf(bufnr)[1] == nil then
        return
      end
      if with_checktime then
        pcall(vim.cmd.checktime, bufnr)
      end
      current.line_kinds = _compute_line_kinds(bufnr)
      current.extmarks = _apply_extmarks(bufnr, current.line_kinds, current.extmarks)
    end)
  )

  _subscribe(git_root, bufnr, refresh)
  refresh()

  vim.api.nvim_buf_attach(bufnr, false, {
    on_lines = function()
      if attach_ids[id] ~= bufnr then
        return true
      end
      refresh()
    end,
    on_reload = function()
      if attach_ids[id] ~= bufnr then
        return
      end
      refresh()
    end,
    on_detach = function()
      _cleanup(bufnr)
    end,
  })

  local augroup = vim.api.nvim_create_augroup(("notomo.lib.git.decorator.%d"):format(bufnr), {})

  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = augroup,
    buf = bufnr,
    callback = function()
      refresh()
    end,
  })
  vim.api.nvim_create_autocmd({ "BufWipeout" }, {
    group = augroup,
    buf = bufnr,
    callback = function()
      _cleanup(bufnr)
    end,
  })
end

return M
