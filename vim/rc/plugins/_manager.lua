local pack_dir = vim.fn.expand("~/.vim/packages")
vim.opt.packpath:prepend(pack_dir)

local manager_dir = pack_dir .. "/pack/optpack/opt/optpack.nvim"
local initializing = vim.fn.isdirectory(manager_dir) ~= 1
if initializing then
  vim.cmd([[!git clone https://github.com/notomo/optpack.nvim ]] .. manager_dir)
end

vim.cmd([[luafile ~/.vim/rc/plugins/_list.lua]])

local scheme_name = "ultramarine"
if initializing then
  require("optpack").update({
    on_finished = function()
      vim.cmd([[colorscheme ]] .. scheme_name)
    end,
  })
else
  vim.schedule(function()
    vim.cmd([[colorscheme ]] .. scheme_name)
  end)
end
