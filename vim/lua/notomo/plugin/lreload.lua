local hooks = {
  optpack = function()
    package.loaded["notomo.plugin._list"] = nil
    require("notomo.plugin._list")
  end,
  notomo = function(args)
    if not args then
      return
    end
    dofile(args.match)
  end,
  ultramarine = function()
    vim.cmd.colorscheme([[ultramarine]])
    vim.api.nvim_exec_autocmds("ColorScheme", {})
  end,
  cmdhndlr = function()
    local plugin = require("optpack").get("cmdhndlr.nvim")
    vim.schedule(function() -- to execute cmdhndlr format autocmd before refresh
      require("lreload").refresh("notomo.plugin.cmdhndlr")
      plugin.opts.hooks.post_add(plugin)
      plugin.opts.hooks.pre_load(plugin)
      plugin.opts.hooks.post_load(plugin)
    end)
  end,
}

local plugins = vim.tbl_filter(function(plugin)
  return plugin.full_name:match("^notomo/")
end, require("optpack").list())

local settings = vim.tbl_map(function(plugin)
  local name = plugin.name:gsub([[%.nvim$]], "")
  return {
    name = name,
    hook = function(args)
      if args then
        require("lreload").refresh("notomo.plugin." .. name)
      end
      plugin.opts.hooks.post_add(plugin)
      plugin.opts.hooks.pre_load(plugin)
      plugin.opts.hooks.post_load(plugin)
    end,
  }
end, plugins)
table.insert(settings, { name = "notomo" })
table.insert(settings, {
  name = "notomo.color",
  hook = hooks.ultramarine,
})

for _, setting in ipairs(settings) do
  require("lreload").enable(setting.name, { post_hook = hooks[setting.name] or setting.hook })
end

return vim.tbl_map(function(setting)
  return setting.name
end, settings)
