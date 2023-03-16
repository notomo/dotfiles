local M = {}

function M.load_plugins()
  local optpack = require("optpack")
  local plugins = optpack.list()
  for _, plugin in ipairs(plugins) do
    optpack.load(plugin.name)
  end
end

function M.update_plugins()
  local optpack = require("optpack")
  optpack.update({
    outputters = {
      bufer = { enabled = false },
      echo = { enabled = true },
    },
    on_finished = function()
      vim.cmd.quitall({ bang = true })
    end,
  })
end

function M.generate_help_tags()
  M.load_plugins()
  vim.cmd.helptags([[ALL]])
  M.schedule([[message | quitall!]])
end

function M.test()
  M.load_plugins()

  vim.cmd.runtime({ args = { "after/ftplugin/*.lua" }, bang = true })

  for _, name in ipairs(require("notomo.plugin.lreload")) do
    require("lreload").refresh(name)
  end

  vim.schedule(function()
    local ok, result = pcall(M._test)
    if not ok then
      vim.api.nvim_echo({ { result, "Error" } }, true, {})
      vim.cmd([[message | cquit!]])
    else
      vim.cmd([[message | quitall!]])
    end
  end)
end

function M._test()
  require("kivi").open()

  require("thetto").start(
    "file/in_dir",
    { opts = { cwd = vim.fn.expand("$DOTFILES/vim/lua/notomo"), input_lines = { "option.lua" } } }
  )
  require("thetto").execute()
  assert(vim.bo.filetype == "lua", "filetype")

  vim.fn.feedkeys("tt", "mx")
  assert(vim.fn.tabpagenr("$") == 2, "tab count")

  vim.fn.feedkeys("th", "mx")
  assert(vim.fn.tabpagenr() == 1, "tab current")

  vim.cmd.lua({ args = { [[require("notomo.startup")._search()]] }, mods = { silent = true } })

  vim.fn.feedkeys("tt", "mx")
  vim.fn.feedkeys("idate", "ix")
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(neosnippet_expand)", true, true, true), "ixm")
  assert(vim.fn.getline(".") ~= "date", "snippet expand")
end

function M._search()
  require("searcho").forward("opt")
  require("searcho").finish()
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

function M.has_doc_plugins()
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

    local doc_script = vim.fn.glob(plugin.directory .. "**/spec/lua/*/doc.lua")
    if vim.fn.filereadable(doc_script) == 0 then
      goto continue
    end

    table.insert(dirs, plugin.directory)
    ::continue::
  end

  io.stdout:write(table.concat(dirs, "\n"))
end

return M
