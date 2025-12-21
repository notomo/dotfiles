local M = {}

function M.view_issue(target)
  local id = vim.fn.substitute(target, "[^[:digit:]]", "", "g")
  local root_url = M.repo_url()
  local url = ("%s/issue/%s"):format(root_url, id)
  require("notomo.lib.browser").open(url)
end

function M.view_pr()
  local target = vim.fn.expand("<cword>")
  local id = vim.fn.substitute(target, "[^[:digit:]]", "", "g")
  local root_url = M.repo_url()
  local url = ("%s/pull/%s"):format(root_url, id)
  require("notomo.lib.browser").open(url)
end

function M.view_repo(target)
  if target then
    target = vim.fn.substitute(target, "^https:\\/\\/", "", "")
    target = vim.fn.substitute(target, "^github\\.com\\/", "", "")
    local root_url = ("https://github.com/%s"):format(target)
    require("notomo.lib.browser").open(root_url)
    return
  end

  local root_url = M.repo_url()
  require("notomo.lib.browser").open(root_url)
end

function M.create_issue()
  vim.cmd.tabedit()
  vim.cmd.terminal()
  vim.fn.chansend(vim.bo.channel, "gh issue create --editor\n")
  vim.cmd.startinsert({ bang = true })
end

function M.repo_name()
  local repo = vim.b.notomo_gh_repo
  if repo then
    return repo
  end

  local result = vim.system({ "git", "remote", "get-url", "origin" }):wait()
  local name = vim.trim(result.stdout):gsub("^@git:github.com/", ""):gsub("^https://github.com/", ""):gsub(".git$", "")
  return name
end

function M.repo_url()
  local name = M.repo_name()
  return ("https://github.com/%s"):format(name)
end

function M.yank_revision_with_repo(revision)
  local name = M.repo_name()
  local name_with_reivision = ("%s@%s"):format(name, revision)
  require("notomo.lib.edit").yank(name_with_reivision)
end

function M.yank_commit_url(revision)
  local root_url = M.repo_url()
  local commit_url = ("%s/commit/%s"):format(root_url, revision)
  require("notomo.lib.edit").yank(commit_url)
end

function M.yank()
  local git_root = require("notomo.lib.git").root()
  if not git_root then
    return require("notomo.lib.message").warn("no .git")
  end

  local root_url = M.repo_url()

  local state = require("thetto.util.git").state() or {}
  local revision = state.revision or require("notomo.lib.git").current_branch()

  local full_path = state.path or vim.api.nvim_buf_get_name(0)
  local path = full_path:sub(#git_root + 2)

  local range_part = ""
  local range = require("misclib.visual_mode").row_range()
  if range then
    range_part = ("#L%d-L%d"):format(range.first, range.last)
    revision = vim.fn.systemlist({ "git", "rev-parse", revision })[1]
  end

  local url = ("%s/blob/%s/%s%s"):format(root_url, revision, path, range_part)
  require("notomo.lib.edit").yank(url)
end

return M
