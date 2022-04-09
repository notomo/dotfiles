local M = {}

function M.load_plugins()
  local optpack = require("optpack")
  local plugins = optpack.list()
  for _, plugin in ipairs(plugins) do
    optpack.load(plugin.name)
  end
end

function M.generate_help_tags()
  M.load_plugins()
  vim.cmd([[helptags ALL]])
  M.schedule([[message | quitall!]])
end

function M.test()
  M.load_plugins()

  local dir = vim.fn.expand("~/dotfiles/vim/after/ftplugin/")
  local pattern = dir .. "**/*.lua"
  local paths = vim.fn.glob(pattern, false, true)
  for _, path in ipairs(paths) do
    local ok, result = pcall(dofile, path)
    if not ok then
      print(result)
    end
  end

  require("kivi").open()
  require("thetto").start("file/in_dir", { opts = { cwd = "~/dotfiles/vim/rc", input_lines = { "option.lua" } } })
  require("thetto").execute()
  assert(vim.bo.filetype == "lua")

  vim.fn.feedkeys("tt", "mx")
  vim.fn.feedkeys("th", "mx")

  M.schedule([[message | quitall!]])
end

function M.schedule(cmd)
  vim.schedule(function()
    vim.schedule(function()
      vim.cmd(cmd)
    end)
  end)
end

function M.plugins()
  local optpack = require("optpack")
  local plugins = optpack.list()

  local dirs = {}
  for _, plugin in ipairs(plugins) do
    if not plugin.full_name:find("notomo/") then
      goto continue
    end

    local lua_dir = plugin.directory .. "/lua"
    if vim.fn.isdirectory(lua_dir) == 0 then
      goto continue
    end

    local makefile = plugin.directory .. "/Makefile"
    if vim.fn.filereadable(makefile) == 0 then
      goto continue
    end

    table.insert(dirs, plugin.directory)
    ::continue::
  end

  io.stdout:write(table.concat(dirs, "\n"))
end

function M.vendorlib_used_plugins()
  local optpack = require("optpack")
  local plugins = optpack.list()

  local dirs = {}
  for _, plugin in ipairs(plugins) do
    if not plugin.full_name:find("notomo/") then
      goto continue
    end

    local lua_dir = plugin.directory .. "/lua"
    if vim.fn.isdirectory(lua_dir) == 0 then
      goto continue
    end

    local vendor_spec = vim.fn.glob(plugin.directory .. "**/vendorlib.lua")
    if vim.fn.filereadable(vendor_spec) == 0 then
      goto continue
    end

    table.insert(dirs, plugin.directory)
    ::continue::
  end

  io.stdout:write(table.concat(dirs, "\n"))
end

return M
