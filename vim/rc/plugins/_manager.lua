local pack_dir = vim.fn.expand("~/.vim/packages")
vim.opt.packpath:prepend(pack_dir)

local manager_dir = pack_dir .. "/pack/optpack/opt/optpack.nvim"
local initializing = vim.fn.isdirectory(manager_dir) ~= 1
if initializing then
  vim.cmd([[!git clone https://github.com/notomo/optpack.nvim ]] .. manager_dir)
end

vim.cmd([[luafile ~/.vim/rc/plugins/_list.lua]])

if initializing then
  require("optpack").update()
end

-- HACK
vim.schedule(function()
  vim.cmd([[
runtime! after/plugin/cmp_*.lua
source ~/.vim/rc/plugins/gina.vim
]])
  require("notomo.cmp").setup()
end)
require("notomo.lsp")
