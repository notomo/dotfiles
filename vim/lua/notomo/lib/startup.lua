local M = {}

function M._load_plugins()
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
  M._load_plugins()
  vim.cmd.helptags([[ALL]])
  M.schedule([[message | quitall!]])
end

function M.test()
  M._load_plugins()

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

  vim.fn.feedkeys("tt", "mx")
  vim.fn.feedkeys("idate", "ix")
  vim.fn.feedkeys(vim.keycode("<Plug>(neosnippet_expand)"), "ixm")
  assert(vim.fn.getline(".") ~= "date", "snippet expand")
end

function M.schedule(cmd)
  vim.schedule(function()
    vim.schedule(function()
      vim.cmd(cmd)
    end)
  end)
end

function M.plugins()
  local dirs = M._get_plugin_dirs(function(plugin)
    local makefile = plugin.directory .. "/Makefile"
    return vim.fn.filereadable(makefile) == 1
  end)
  io.stdout:write(table.concat(dirs, "\n"))
end

function M.vendorlib_used_plugins()
  local dirs = M._get_plugin_dirs(function(plugin)
    local vendor_spec = vim.fn.glob(plugin.directory .. "**/vendorlib.lua")
    return vim.fn.filereadable(vendor_spec) == 1
  end)
  io.stdout:write(table.concat(dirs, "\n"))
end

function M.has_doc_plugins()
  local dirs = M._get_plugin_dirs(function(plugin)
    local doc_script = vim.fn.glob(plugin.directory .. "**/spec/lua/*/doc.lua")
    return vim.fn.filereadable(doc_script) == 1
  end)
  io.stdout:write(table.concat(dirs, "\n"))
end

function M.plugin_shared_dirs()
  local dirs = M._get_plugin_dirs(function(plugin)
    local shared_dir = vim.fn.glob(plugin.directory .. "**/spec/.shared")
    return vim.fn.isdirectory(shared_dir) == 1
  end)
  local shared_dirs = vim.tbl_map(function(dir)
    return vim.fs.joinpath(dir, "spec/.shared")
  end, dirs)
  io.stdout:write(table.concat(shared_dirs, "\n"))
end

function M._get_plugin_dirs(filter)
  return vim
    .iter(require("optpack").list())
    :map(function(plugin)
      if not plugin.full_name:find("notomo/") then
        return
      end

      local lua_dir = plugin.directory .. "/lua"
      if vim.fn.isdirectory(lua_dir) == 0 then
        return
      end

      if not filter(plugin) then
        return
      end

      return plugin.directory
    end)
    :totable()
end

return M
