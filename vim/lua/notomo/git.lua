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

function M.root()
  local current_dir = vim.fn.getcwd()
  if vim.fn.isdirectory(current_dir .. "/.git") == 1 then
    return current_dir
  end
  for dir in vim.fs.parents(current_dir) do
    if vim.fn.isdirectory(dir .. "/.git") == 1 then
      return dir
    end
  end
  return nil
end

function M.current_branch()
  if vim.b.gitsigns_head then
    return vim.b.gitsigns_head
  end
  if (vim.bo.filetype == "kivi-file" or vim.bo.buftype == "terminal") and vim.g.gitsigns_head then
    return vim.g.gitsigns_head
  end
  return ""
end

function M.yank_commit_message(revision)
  local message = vim.fn.systemlist({ "git", "log", "--format=%B", "-n", "1", revision })[1]
  require("notomo.edit").yank(message)
end

return M
