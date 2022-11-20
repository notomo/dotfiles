local M = {}

function M._revision()
  local tmp = vim.fn.getreg("+")
  vim.fn["gina#action#call"]("yank:rev")
  local revision = vim.fn.getreg("+")
  vim.fn.setreg("+", tmp)
  return revision
end

function M.fixup()
  local revision = M._revision()
  vim.cmd.Gina({ args = { "commit", "--fixup=" .. revision }, bang = true })
end

function M.rebase_i()
  local revision = M._revision()
  vim.cmd.terminal()
  vim.fn.jobsend(
    vim.b.terminal_job_id,
    "git rebase -i --autosquash " .. revision .. "~" .. vim.api.nvim_eval([["\<CR>"]])
  )
end

function M.yank_rev()
  vim.fn["gina#action#call"]("yank:rev")
  vim.api.nvim_echo({ { vim.fn.getreg("+") } }, true, {})
end

function M.yank_rev_with_repo()
  vim.fn["gina#action#call"]("yank:rev")
  local name = vim.fn.systemlist({
    "gh",
    "repo",
    "view",
    "--json",
    "nameWithOwner",
    "--template",
    "{{.nameWithOwner}}",
  })[1]
  local rev = vim.fn.getreg("+")
  local name_with_rev = ("%s@%s"):format(name, rev)
  require("notomo.edit").yank(name_with_rev)
end

function M.yank_commit_message()
  local revision = M._revision()
  local message = vim.fn.systemlist({ "git", "log", "--format=%B", "-n", "1", revision })[1]
  require("notomo.edit").yank(message)
end

function M.yank_commit_url()
  vim.fn["gina#action#call"]("browse:yank:exact")
  local url = vim.fn.getreg("+"):gsub("/tree/", "/commit/")
  require("notomo.edit").yank(url)
end

function M.relpath()
  local git = vim.fn["gina#core#get_or_fail"]()
  local abspath = vim.fn["gina#core#repo#abspath"](git, "")
  local curpath = vim.fn.substitute(vim.fn.expand("%:p"), "\\", "/", "g")
  return vim.fn.substitute(curpath, abspath, "", "")
end

return M
