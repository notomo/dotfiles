local M = {}

function M.view_issue(target)
  local id = vim.fn.substitute(target, "[^[:digit:]]", "", "g")
  local cmd = { "gh", "issue", "view", id, "--web" }
  local repo = vim.b.notomo_gh_repo
  if repo then
    table.insert(cmd, "--repo=" .. repo)
  end
  require("notomo.lib.job").run(cmd)
end

function M.view_pr()
  local target = vim.fn.expand("<cword>")
  local id = vim.fn.substitute(target, "[^[:digit:]]", "", "g")
  local cmd = { "gh", "pr", "view", "--web" }
  if id ~= "" then
    table.insert(cmd, id)
  end
  require("notomo.lib.job").run(cmd)
end

function M.view_repo(target)
  local cmd = { "gh", "repo", "view", "--web" }
  if target then
    target = vim.fn.substitute(target, "^https:\\/\\/", "", "")
    target = vim.fn.substitute(target, "^github\\.com\\/", "", "")
  end
  if target ~= "" then
    table.insert(cmd, target)
  end
  require("notomo.lib.job").run(cmd)
end

function M.create_issue()
  vim.cmd.tabedit()
  vim.cmd.terminal()
  vim.fn.chansend(vim.bo.channel, "gh issue create --editor\n")
  vim.cmd.startinsert({ bang = true })
end

function M.yank_revision_with_repo(revision)
  local name = vim.fn.systemlist({
    "gh",
    "repo",
    "view",
    "--json",
    "nameWithOwner",
    "--template",
    "{{.nameWithOwner}}",
  })[1]
  local name_with_reivision = ("%s@%s"):format(name, revision)
  require("notomo.lib.edit").yank(name_with_reivision)
end

function M.yank_commit_url(revision)
  local url = vim.fn.systemlist({
    "gh",
    "browse",
    "--no-browser",
    revision,
  })[1]
  require("notomo.lib.edit").yank(url)
end

function M.yank()
  local git_root = require("notomo.lib.git").root()
  if not git_root then
    return require("misclib.message").warn("no .git")
  end

  local root_url = vim.fn.systemlist({
    "gh",
    "browse",
    "--no-browser",
  })[1]

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

function M.edit_issue(url, field)
  local util = require("pluginbuf.util")
  require("pluginbuf").register("gh-repo-issue", {
    {
      path = util.path(field),
      read = function(ctx)
        return util.cmd_output({ "gh", "issue", "view", url, "--json=" .. field, "--jq=." .. field })(ctx)
      end,
      write = function(ctx)
        return util.cmd_input({ "gh", "issue", "edit", url, "--" .. field, "-" })(ctx)
      end,
    },
  })
  vim.cmd.tabedit("gh-repo-issue://" .. field)
end

return M
