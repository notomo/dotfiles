vim.keymap.set("n", "<Space>c", [[<Plug>(caw:wrap:toggle:operator)_]], { buffer = true })
vim.keymap.set("x", "<Space>c", [[<Plug>(caw:wrap:toggle:operator)]], { buffer = true })
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

if vim.b.docfilter then
  vim.keymap.set("n", "<CR>", function()
    require("docfilter").navigate({
      open = function(bufnr)
        vim.cmd.buffer({ count = bufnr })
      end,
    })
  end, { buffer = true })
end
