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

local watchers = {}

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
      local watcher = watchers[bufnr]
      if watcher then
        watcher:stop()
        watcher:close()
        watchers[bufnr] = nil
      end
      clear()
    end,
    once = true,
  })

  local old_watcher = watchers[bufnr]
  if old_watcher then
    old_watcher:stop()
    old_watcher:close()
  end

  local watcher = vim.uv.new_fs_event()
  if not watcher then
    return branch
  end

  watchers[bufnr] = watcher
  watcher:start(head_file_path, {}, function()
    watchers[bufnr] = nil
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

function M.reset_selection()
  local v_row = vim.fn.getpos("v")[2]
  local cur_row = vim.fn.getpos(".")[2]
  require("misclib.visual_mode").leave()

  local sel_start = math.min(v_row, cur_row)
  local sel_end = math.max(v_row, cur_row)

  local git_root = M.root()
  if not git_root then
    return require("notomo.lib.message").warn("not a git repository")
  end

  local full_path = vim.fs.normalize(vim.api.nvim_buf_get_name(0))
  local rel_path = vim.fs.relpath(git_root, full_path)
  if not rel_path then
    return require("notomo.lib.message").warn("not under git root")
  end

  local result = vim.system({ "git", "-C", git_root, "show", "HEAD:" .. rel_path }):wait()
  if result.code ~= 0 then
    return require("notomo.lib.message").warn(vim.trim(result.stderr or ""))
  end

  local head_lines = vim.split(result.stdout:gsub("\n$", ""), "\n", { plain = true })
  local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local head_text = table.concat(head_lines, "\n") .. "\n"
  local current_text = table.concat(current_lines, "\n") .. "\n"

  local hunks = vim.text.diff(head_text, current_text, { result_type = "indices" })
  if not hunks or #hunks == 0 then
    return
  end

  for i = #hunks, 1, -1 do
    local h = hunks[i]
    local start_a, count_a, start_b, count_b = h[1], h[2], h[3], h[4]

    local overlaps
    if count_b == 0 then
      overlaps = start_b + 1 >= sel_start and start_b <= sel_end
    else
      local b_first = start_b
      local b_last = start_b + count_b - 1
      overlaps = not (b_last < sel_start or b_first > sel_end)
    end
    if overlaps then
      local replacement = {}
      for j = start_a, start_a + count_a - 1 do
        table.insert(replacement, head_lines[j])
      end
      local set_first = count_b == 0 and start_b or (start_b - 1)
      local set_last = count_b == 0 and start_b or (start_b - 1 + count_b)
      vim.api.nvim_buf_set_lines(0, set_first, set_last, false, replacement)
    end
  end
end

return M
