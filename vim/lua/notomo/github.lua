local M = {}

function M.view_issue(target)
  local id = vim.fn.substitute(target, "[^[:digit:]]", "", "g")
  local cmd = {"gh", "issue", "view", id, "--web"}
  local repo = vim.b.notomo_gh_repo
  if repo then
    table.insert(cmd, "--repo=" .. repo)
  end
  require("notomo.job").run(cmd)
end

function M.view_pr()
  local target = vim.fn.expand("<cword>")
  local id = vim.fn.substitute(target, "[^[:digit:]]", "", "g")
  local cmd = {"gh", "pr", "view", "--web"}
  if id ~= "" then
    table.insert(cmd, id)
  end
  require("notomo.job").run(cmd)
end

function M.view_repo(target)
  local cmd = {"gh", "repo", "view", "--web"}
  if target then
    target = vim.fn.substitute(target, "^https:\\/\\/", "", "")
    target = vim.fn.substitute(target, "^github\\.com\\/", "", "")
  end
  if target ~= "" then
    table.insert(cmd, target)
  end
  require("notomo.job").run(cmd)
end

return M
