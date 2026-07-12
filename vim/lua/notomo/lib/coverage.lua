local M = {}

local group_name = "notomo.coverage"

local function is_enabled()
  local ok, autocmds = pcall(vim.api.nvim_get_autocmds, { group = group_name })
  return ok and #autocmds > 0
end

local function stats_path(bufnr)
  local git_root = vim.fs.root(bufnr, { ".git" })
  if not git_root then
    return nil
  end
  local path = vim.fs.joinpath(git_root, "spec/.shared/luacov.stats.out")
  if not vim.uv.fs_stat(path) then
    return nil
  end
  return path
end

local function decorate(bufnr)
  local path = stats_path(bufnr)
  if not path then
    return
  end
  require("ntf.coverage").decorate({ enable = true, buffer = bufnr, path = path })
end

function M.toggle()
  if not is_enabled() then
    local group = vim.api.nvim_create_augroup(group_name, {})
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      group = group,
      pattern = { "*" },
      callback = function(args)
        decorate(args.buf)
      end,
    })
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        decorate(bufnr)
      end
    end
    return
  end

  pcall(vim.api.nvim_del_augroup_by_name, group_name)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      require("ntf.coverage").decorate({ enable = false, buffer = bufnr })
    end
  end
end

return M
