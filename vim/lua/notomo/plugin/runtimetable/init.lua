local path = vim.fs.joinpath(vim.fn.stdpath("data"), "notomo_runtimetable")
vim.opt.runtimepath:prepend(path)
vim.opt.runtimepath:append(vim.fs.joinpath(path, "after"))

vim.keymap.set("n", "[exec]do", function()
  local cwd = vim.fn.getcwd()
  vim.cmd.drop({
    mods = { tab = vim.fn.tabpagenr() },
    args = { vim.fn.expand("~/.local/.mytodo") },
  })
  vim.w[0].notomo_disable_autocd = true
  vim.fn.chdir(cwd, "window")
end)
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
    vim.fs.rm(path, { force = true, recursive = true })
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
