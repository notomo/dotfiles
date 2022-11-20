local M = {}

vim.api.nvim_create_user_command("Git", function(command)
  local args = command.fargs
  require("notomo.job").run({ "git", unpack(args) })
end, { nargs = "+" })

function M.pull()
  local remote = M._remote()
  local branch = M._current_branch()
  return (":<C-u>Git pull %s %s"):format(remote, branch)
end

function M.push()
  local remote = M._remote()
  local branch = M._current_branch()
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

function M._current_branch()
  local git_root
  for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
    if vim.fn.isdirectory(dir .. "/.git") == 1 then
      git_root = dir
      break
    end
  end
  if not git_root then
    return ""
  end

  local head = git_root .. "/.git/HEAD"
  local f = io.open(head)
  if not f then
    return ""
  end
  local content = vim.trim(f:read("*a"))
  f:close()

  local ref = vim.split(content, " ", true)[2]
  local branch = ref:sub(#"refs/heads/" + 1)
  return branch
end

function M.yank_commit_message(revision)
  local message = vim.fn.systemlist({ "git", "log", "--format=%B", "-n", "1", revision })[1]
  require("notomo.edit").yank(message)
end

return M
