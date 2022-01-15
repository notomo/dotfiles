if vim.bo.buftype ~= "help" then
  vim.opt_local.list = true
  vim.opt_local.tabstop = 8
  vim.opt_local.shiftwidth = 8
  vim.opt_local.softtabstop = 8
  vim.opt_local.expandtab = false
  vim.opt_local.textwidth = 78
  vim.opt_local.colorcolumn = "+1"
  vim.opt_local.conceallevel = 0
end
