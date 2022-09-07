local pack_dir = vim.fn.expand("~/.vim/packages")
vim.opt.packpath:prepend(pack_dir)

local manager_dir = pack_dir .. "/pack/mypack/opt/optpack.nvim"
local initializing = vim.fn.isdirectory(manager_dir) ~= 1
if initializing then
  vim.cmd["!"]({ args = { "git", "clone", "https://github.com/notomo/optpack.nvim", manager_dir } })
end

vim.cmd.luafile([[~/dotfiles/vim/lua/notomo/plugin/_list.lua]])

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
