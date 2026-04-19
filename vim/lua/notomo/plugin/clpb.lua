vim.keymap.set({ "n", "x" }, "p", function()
  vim.schedule(function()
    require("clpb").on_pasted()
  end)
  return "p"
end, { expr = true })

vim.keymap.set({ "n", "x" }, "P", function()
  vim.schedule(function()
    require("clpb").on_pasted()
  end)
  return "P"
end, { expr = true })

vim.keymap.set("n", "<C-n>", function()
  require("clpb").next()
end)
vim.keymap.set("n", "<C-p>", function()
  require("clpb").prev()
end)

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("notomo.clpb", {}),
  callback = function()
    require("clpb").yank({ lines = vim.v.event.regcontents, regtype = vim.v.event.regtype })
  end,
})
