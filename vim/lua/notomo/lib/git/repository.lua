local M = {}

vim.api.nvim_create_user_command("Git", function(command)
  local args = command.fargs
  require("notomo.lib.job").run({ "git", unpack(args) })
end, { nargs = "+" })

function M.pull(args)
  local remote = M._remote()
  local branch = require("notomo.lib.git.branch").current()
  if branch == "" then
    require("notomo.lib.message").warn("no specific branch")
    return ""
  end
  local cmd = { "pull", remote, branch, unpack(args or {}) }
  return (":<C-u>Git %s"):format(table.concat(cmd, " "))
end

function M.push()
  local remote = M._remote()
  local branch = require("notomo.lib.git.branch").current()
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

function M.yank_commit_message(revision)
  local message = vim.fn.systemlist({ "git", "log", "--format=%B", "-n", "1", revision })[1]
  require("notomo.lib.edit").yank(message)
end

return M
