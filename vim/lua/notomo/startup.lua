local M = {}

function M.test()
  local optpack = require("optpack")
  local plugins = optpack.list()
  for _, plugin in ipairs(plugins) do
    optpack.load(plugin.name)
  end

  require("kivi").open()
  require("thetto").start("file/in_dir", { opts = { cwd = "~/dotfiles/vim/rc", input_lines = { "option.lua" } } })
  require("thetto").execute()
  assert(vim.bo.filetype == "lua")

  vim.schedule(function()
    vim.schedule(function()
      vim.cmd([[messages | quitall!]])
    end)
  end)
end

return M
