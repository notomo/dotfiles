local pack_dir = vim.fs.joinpath(tostring(vim.fn.stdpath("config")), "packages")
vim.opt.packpath:prepend(pack_dir)

local manager_dir = vim.fs.joinpath(pack_dir, "pack/mypack/opt/optpack.nvim")
local initializing = vim.fn.isdirectory(manager_dir) ~= 1
if initializing then
  vim.cmd["!"]({ args = { "git", "clone", "https://github.com/notomo/optpack.nvim", manager_dir } })
end

require("notomo.plugin._list")

if initializing then
  require("optpack").update({
    on_finished = function()
      vim.cmd.colorscheme(vim.g.notomo_colorscheme)
    end,
  })
else
  vim.schedule(function()
    vim.cmd.colorscheme(vim.g.notomo_colorscheme)
  end)
end
