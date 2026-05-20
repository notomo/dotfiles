vim.keymap.set("n", "<C-n>", function()
  require("clpb").next()
end)
vim.keymap.set("n", "<C-p>", function()
  require("clpb").prev()
end)

local group = vim.api.nvim_create_augroup("notomo.clpb", {})

vim.api.nvim_create_autocmd("TextPutPost", {
  group = group,
  callback = function()
    require("clpb").on_pasted()
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    require("clpb").yank({ lines = vim.v.event.regcontents, regtype = vim.v.event.regtype })
  end,
})
