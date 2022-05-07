local M = {}

function M.remote()
  local branch = vim.fn["gina#component#repo#branch"]()
  local tracking = vim.fn["gina#component#repo#track"]()
  local remote_name = tracking:sub(1, #tracking - #branch - 1)
  if remote_name == "" then
    return "origin"
  end
  return remote_name
end

function M._revision()
  local tmp = vim.fn.getreg("+")
  vim.fn["gina#action#call"]("yank:rev")
  local revision = vim.fn.getreg("+")
  vim.fn.setreg("+", tmp)
  return revision
end

function M._path()
  local tmp = vim.fn.getreg("+")
  vim.fn["gina#action#call"]("yank:path")
  local path = vim.fn.getreg("+")
  vim.fn.setreg("+", tmp)
  return path
end

function M.toggle_buffer(cmd, filetype)
  if vim.bo.filetype ~= filetype then
    return vim.cmd("Gina " .. cmd)
  end
  if #vim.fn.tabpagebuflist(vim.fn.tabpagenr()) == 1 then
    return vim.cmd("edit #")
  end
  vim.cmd("quit")
end

function M.push_cmd()
  local revision = M._revision()
  return "Gina! push origin " .. revision
end

function M.fixup()
  local revision = M._revision()
  vim.cmd("Gina! commit --fixup=" .. revision)
end

function M.rebase_i()
  local revision = M._revision()
  vim.cmd("terminal")
  vim.fn.jobsend(
    vim.b.terminal_job_id,
    "git rebase -i --autosquash " .. revision .. "~" .. vim.api.nvim_eval([["\<CR>"]])
  )
end

function M.stash_file()
  local path = M._path()
  vim.cmd("Gina! stash -- " .. path)
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

function M.browse_yank()
  vim.fn["gina#action#call"]("browse:yank")
  vim.api.nvim_echo({ { vim.fn.getreg("+") } }, true, {})
end

function M.edit(action)
  local splitted = vim.split(vim.fn.getline("."), " ")
  if #splitted == 0 then
    return
  end
  local file_part = splitted[#splitted]
  file_part = vim.fn.substitute(file_part, "\\v(\\t\\e[31m|\\e\\[m)", "", "g")
  local git = vim.fn["gina#core#get_or_fail"]()
  local abspath = vim.fn["gina#core#repo#abspath"](git, "")
  local path = abspath .. file_part

  if action == "edit:tab" then
    local window_id = vim.api.nvim_get_current_win()
    vim.cmd("tabnew")
    vim.api.nvim_win_close(window_id, true)
  end
  if vim.fn.isdirectory(path) == 0 then
    return vim.cmd([[Gina edit ]] .. file_part)
  end

  vim.cmd("lcd " .. path)
  require("kivi").open()
end

function M.relpath()
  local git = vim.fn["gina#core#get_or_fail"]()
  local abspath = vim.fn["gina#core#repo#abspath"](git, "")
  local curpath = vim.fn.substitute(vim.fn.expand("%:p"), "\\", "/", "g")
  return vim.fn.substitute(curpath, abspath, "", "")
end

return M
