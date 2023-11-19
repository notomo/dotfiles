local path = vim.fn.stdpath("data") .. "/notomo_runtimetable"
vim.opt.runtimepath:prepend(path)
vim.opt.runtimepath:append(path .. "/after")

vim.keymap.set("n", "[exec]do", [[<Cmd>tab drop ~/.local/.mytodo<CR>]])
vim.filetype.add({
  filename = {
    [".mytodo"] = "mytodo",
  },
})

return {
  path = path,
  save = function(runtime)
    require("runtimetable").save(runtime, { as_binary = vim.fn.has("win32") ~= 1 })
  end,
  save_all = function()
    vim
      .iter(vim.api.nvim_get_runtime_file("lua/notomo/plugin/runtimetable/*.lua", true))
      :filter(function(file_path)
        return vim.fs.basename(file_path) ~= "init.lua"
      end)
      :each(function(file_path)
        dofile(file_path)
      end)
  end,
}
