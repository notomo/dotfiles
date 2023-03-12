local path = vim.fn.stdpath("data") .. "/notomo_runtimetable"
vim.opt.runtimepath:prepend(path)
vim.opt.runtimepath:append(path .. "/after")

vim.filetype.add({
  filename = {
    [".mytodo"] = "mytodo",
  },
})

return {
  path = path,
}
