local M = {}

function M._load_plugins()
  local optpack = require("optpack")
  local promises = vim
    .iter(optpack.list())
    :map(function(plugin)
      return require("promise").new(function(resolve)
        optpack.load(plugin.name, { on_finished = resolve })
      end)
    end)
    :totable()
  return require("promise").all(promises)
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
    :next(function()
      vim.cmd.helptags([[ALL]])
    end)
    :finally(function()
      vim.cmd([[message | quitall!]])
    end)
end

function M.test()
  M._load_plugins()
    :next(function()
      for _, name in ipairs(require("notomo.plugin.lreload")) do
        require("lreload").refresh(name)
      end
    end)
    :next(M._test)
    :next(function()
      vim.cmd([[message | quitall!]])
    end)
    :catch(function(err)
      vim.api.nvim_echo({ { err, "Error" } }, true, {})
      vim.cmd([[message | cquit!]])
    end)
end

function M._test()
  return require("promise")
    .new(function(resolve)
      return resolve(require("kivi").open())
    end)
    :next(function()
      vim.cmd.tabedit()
      vim.cmd.tabonly()

      vim.fn.feedkeys("tt", "mx")
      assert(vim.fn.tabpagenr("$") == 2, "tab count")

      vim.fn.feedkeys("th", "mx")
      assert(vim.fn.tabpagenr() == 1, "tab current")

      vim.fn.feedkeys("tt", "mx")
      vim.fn.feedkeys("idate", "ix")
      vim.fn.feedkeys(vim.keycode("<Plug>(neosnippet_expand)"), "ixm")
      assert(vim.fn.getline(".") ~= "date", "snippet expand")
    end)
end

function M.plugins()
  local dirs = M._get_plugin_dirs(function(plugin)
    local makefile = vim.fs.joinpath(plugin.directory, "Makefile")
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

  local shared_dirs = vim
    .iter(dirs)
    :map(function(dir)
      return {
        vim.fs.joinpath(dir, "spec/.shared"),
        vim.fs.joinpath(dir, "spec/.shared/packages/pack/testpack/start/assertlib.nvim"),
        vim.fs.joinpath(dir, "spec/.shared/packages/pack/testpack/start/requireall.nvim"),
      }
    end)
    :flatten()
    :filter(function(path)
      return vim.fn.isdirectory(path) == 1
    end)
    :totable()

  io.stdout:write(table.concat(shared_dirs, "\n"))
end

function M._get_plugin_dirs(filter)
  return vim
    .iter(require("optpack").list())
    :map(function(plugin)
      if not plugin.directory:find("mypack/") then
        return
      end

      local lua_dir = vim.fs.joinpath(plugin.directory, "lua")
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

function M.quit_after_start()
  vim.api.nvim_create_autocmd({ "UIEnter" }, {
    group = vim.api.nvim_create_augroup("notomo.startup", {}),
    pattern = { "*" },
    callback = function()
      vim.schedule(function()
        vim.cmd.quit()
      end)
    end,
  })
end

function M.update_runtimetable()
  local ok, result = pcall(function()
    require("notomo.plugin.runtimetable").save_all()
  end)
  if not ok then
    vim.notify(result)
  end
  vim.cmd([[message | quitall!]])
end

function M.requireall()
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.notify = function(msg)
    io.stdout:write(msg .. "\n")
  end

  M._load_plugins():next(function()
    require("requireall").execute({
      module_filter = function(module_path)
        local ignore = vim.iter({ "copilot", "CopilotChat" }):any(function(x)
          local found = module_path:find(x)
          return found ~= nil
        end)
        if ignore then
          return false
        end
        return true
      end,
    })
  end)
end

return M
