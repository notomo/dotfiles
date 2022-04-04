local hooks = {
  optpack = function()
    dofile(vim.fn.expand("~/dotfiles/vim/rc/plugins/_list.lua"))
  end,
  stlparts = function()
    require("notomo.stlparts").setup()
  end,
  thetto = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/thetto.lua"))
  end,
  curstr = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/curstr.lua"))
  end,
  piemenu = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/piemenu.lua"))
  end,
  aliaser = function()
    dofile(vim.fn.expand("~/dotfiles/vim/rc/plugins/aliaser.lua"))
  end,
  gesture = function()
    dofile(vim.fn.expand("~/.vim/rc/plugins/gesture.lua"))
  end,
}

local plugins = vim.tbl_filter(function(plugin)
  return plugin.full_name:find("notomo/") and plugin.full_name:find(".nvim$")
end, require("optpack").list())

local names = vim.tbl_map(function(plugin)
  return plugin.name:gsub([[%.nvim$]], "")
end, plugins)
table.insert(names, "notomo")

for _, name in ipairs(names) do
  require("lreload").enable(name, { post_hook = hooks[name] })
end
