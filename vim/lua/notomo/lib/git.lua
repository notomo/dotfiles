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
  local path = vim.fn.fnamemodify(vim.fn.bufname(), ":p")
  return (":<C-u>Git apply %s"):format(path)
end

function M.cmd(cmd)
  return (":<C-u>Git %s"):format(table.concat(cmd, " "))
end

function M._remote()
  return "origin"
end

function M.root()
  return vim.fs.root(vim.fn.getcwd(), { ".git" })
end

local watchers = {}

function M.branch_component()
  if vim.b.gitsigns_head then
    return vim.b.gitsigns_head
  end

  if vim.b.notomo_git_branch then
    return vim.b.notomo_git_branch
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local clear = function()
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    vim.b[bufnr].notomo_git_branch = nil
  end

  local head_file_path = M._head_file_path()
  if not head_file_path then
    return ""
  end

  local branch = M._current_branch(head_file_path)
  local events = vim.tbl_contains({ "kivi-file" }, vim.bo.filetype) and { "BufReadCmd" } or { "BufRead" }
  vim.api.nvim_create_autocmd(events, {
    buffer = bufnr,
    callback = function()
      watchers[bufnr] = nil
      clear()
    end,
    once = true,
  })

  local old_watcher = watchers[bufnr]
  if old_watcher then
    old_watcher:stop()
  end

  local watcher = vim.uv.new_fs_event()
  if not watcher then
    return branch
  end

  watchers[bufnr] = watcher
  watcher:start(head_file_path, {}, function()
    watchers[bufnr] = nil
    watcher:stop()
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

return M
