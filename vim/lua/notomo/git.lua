local vim = vim

local M = {}

vim.api.nvim_create_user_command("Git", function(command)
  local args = command.fargs
  require("notomo.job").run({ "git", unpack(args) })
end, { nargs = "+" })

function M.pull()
  local remote = M._remote()
  local branch = M.current_branch()
  return (":<C-u>Git pull %s %s"):format(remote, branch)
end

function M.push()
  local remote = M._remote()
  local branch = M.current_branch()
  return (":<C-u>Git push %s %s"):format(remote, branch)
end

function M.fetch()
  local remote = M._remote()
  return (":<C-u>Git fetch %s --prune"):format(remote)
end

function M.apply()
  local path = vim.fn.fnamemodify(vim.fn.bufname("%"), ":p")
  return (":<C-u>Git apply %s"):format(path)
end

function M.cmd(cmd)
  return (":<C-u>Git %s"):format(table.concat(cmd, " "))
end

function M._remote()
  return "origin"
end

function M._head_file_path()
  local git_root
  for dir in vim.fs.parents(vim.fn.getcwd()) do
    if vim.fn.isdirectory(dir .. "/.git") == 1 then
      git_root = dir
      break
    end
  end
  if not git_root then
    return nil
  end
  return git_root .. "/.git/HEAD"
end

function M.current_branch()
  local head = M._head_file_path()
  if not head then
    return ""
  end
  local f = io.open(head)
  if not f then
    return ""
  end
  local content = vim.trim(f:read("*a"))
  f:close()

  local splitted = vim.split(content, " ", true)
  if #splitted == 1 then
    return splitted[1]
  end

  local ref = splitted[2]
  local branch = ref:sub(#"refs/heads/" + 1)
  return branch
end

local watchers = {}
local buffer_cache = {}
function M.branch_component()
  local bufnr = vim.fn.bufnr("%")
  local buffer_cached = buffer_cache[bufnr]
  if buffer_cached then
    return buffer_cached
  end

  local head = M._head_file_path()
  if not head then
    buffer_cache[bufnr] = ""
    return ""
  end

  local cached = watchers[head]
  if cached then
    buffer_cache[bufnr] = cached.branch
    return cached.branch
  end

  local branch = M.current_branch()
  local watcher = {
    event = vim.loop.new_fs_event(),
    branch = branch,
  }
  watchers[head] = watcher
  buffer_cache[bufnr] = branch
  watcher.event:start(head, {}, function()
    watcher.event:close()
    watchers[head] = nil
    buffer_cache = {}
  end)
  return branch
end

function M.yank_commit_message(revision)
  local message = vim.fn.systemlist({ "git", "log", "--format=%B", "-n", "1", revision })[1]
  require("notomo.edit").yank(message)
end

return M
