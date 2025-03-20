local pre_hooks = {
  thetto = function()
    vim.api.nvim_exec_autocmds("User", {
      pattern = "ThettoStoreSaveTrigger",
      modeline = false,
    })
  end,
  multito = function()
    vim.iter(vim.api.nvim_list_bufs()):each(function(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      local name = vim.api.nvim_buf_get_name(bufnr)
      if not vim.startswith(name, "multito") then
        return
      end

      local panel = require("multito.copilot").panel_get({ bufnr = bufnr })
      if not panel then
        return
      end

      vim.b[bufnr].multito_copilot_panel_debug_state = {
        source_bufnr = panel.source_bufnr,
        items = panel.items,
        current_index = panel.current_index,
        done = panel.done,
        client_id = panel.client_id,
      }
    end)
  end,
}

local post_hooks = {
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

local plugins = vim
  .iter(require("optpack").list())
  :filter(function(plugin)
    return plugin.full_name:match("^notomo/")
  end)
  :totable()

local settings = vim
  .iter(plugins)
  :map(function(plugin)
    local name = plugin.name:gsub([[%.nvim$]], "")
    return {
      name = name,
      post_hook = function(args)
        if args then
          require("lreload").refresh("notomo.plugin." .. name)
        end
        plugin.opts.hooks.post_add(plugin)
        plugin.opts.hooks.pre_load(plugin)
        plugin.opts.hooks.post_load(plugin)
      end,
    }
  end)
  :totable()
table.insert(settings, { name = "notomo" })
table.insert(settings, {
  name = "notomo.color",
  post_hook = post_hooks.ultramarine,
})

for _, setting in ipairs(settings) do
  require("lreload").enable(setting.name, {
    pre_hook = pre_hooks[setting.name] or setting.pre_hook,
    post_hook = post_hooks[setting.name] or setting.post_hook,
  })
end

local names = vim
  .iter(settings)
  :map(function(setting)
    return setting.name
  end)
  :totable()
return names
