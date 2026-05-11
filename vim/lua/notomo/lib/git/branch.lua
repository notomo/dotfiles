local M = {}

local branch_watchers = {}

function M.component()
  if vim.b.notomo_git_branch then
    return vim.b.notomo_git_branch
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local function clear()
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

function M.current()
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
  local git_root = require("notomo.lib.git.repository").root()
  if not git_root then
    return nil
  end
  return vim.fs.joinpath(git_root, ".git/HEAD")
end

return M
