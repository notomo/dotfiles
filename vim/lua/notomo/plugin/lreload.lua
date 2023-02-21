local hooks = {
  optpack = function()
    vim.cmd.luafile("~/dotfiles/vim/lua/notomo/plugin/_list.lua")
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
}

local plugins = vim.tbl_filter(function(plugin)
  return plugin.full_name:match("^notomo/.+%.nvim$")
end, require("optpack").list())

local settings = vim.tbl_map(function(plugin)
  return {
    name = plugin.name:gsub([[%.nvim$]], ""),
    hook = function()
      plugin.opts.hooks.post_add(plugin)
      plugin.opts.hooks.pre_load(plugin)
      plugin.opts.hooks.post_load(plugin)
    end,
  }
end, plugins)
table.insert(settings, { name = "notomo" })

for _, setting in ipairs(settings) do
  require("lreload").enable(setting.name, { post_hook = hooks[setting.name] or setting.hook })
end

return vim.tbl_map(function(setting)
  return setting.name
end, settings)
