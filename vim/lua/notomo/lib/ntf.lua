local M = {}

--- @param opts {name:string, group_name:string, relative_path:string, decorate:fun(o:table)}
local function toggler(opts)
  local function is_enabled()
    local ok, autocmds = pcall(vim.api.nvim_get_autocmds, { group = opts.group_name })
    return ok and #autocmds > 0
  end

  local function decorate(bufnr)
    local git_root = vim.fs.root(bufnr, { ".git" })
    if not git_root then
      return
    end
    local path = vim.fs.joinpath(git_root, opts.relative_path)
    if not vim.uv.fs_stat(path) then
      return
    end
    opts.decorate({ enable = true, buffer = bufnr, path = path })
  end

  return function()
    if not is_enabled() then
      local group = vim.api.nvim_create_augroup(opts.group_name, {})
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
      require("notomo.lib.message").info(("%s: on"):format(opts.name))
      return
    end

    pcall(vim.api.nvim_del_augroup_by_name, opts.group_name)
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        opts.decorate({ enable = false, buffer = bufnr })
      end
    end
    require("notomo.lib.message").info(("%s: off"):format(opts.name))
  end
end

M.toggle_coverage = toggler({
  name = "coverage",
  group_name = "notomo.ntf.coverage",
  relative_path = "spec/.shared/luacov.stats.out",
  decorate = function(o)
    require("ntf.coverage").decorate(o)
  end,
})

M.toggle_mutation = toggler({
  name = "mutation",
  group_name = "notomo.ntf.mutation",
  relative_path = "spec/.shared/ntf-mutation.json",
  decorate = function(o)
    require("ntf.mutation").decorate(o)
  end,
})

return M
