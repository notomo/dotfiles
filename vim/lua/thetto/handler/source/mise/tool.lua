local M = {}

function M.collect(source_ctx)
  local cmd = { "mise", "ls", "-J" }
  return require("thetto.util.job").run(cmd, source_ctx, function(output)
    return {
      value = ("%s@%s"):format(output.name, output.version),
      name = output.name,
      version = output.version,
      path = output.install_path,
    }
  end, {
    to_outputs = function(output)
      local decoded = vim.json.decode(output, { luanil = { object = true } })
      local outputs = {}
      for name, versions in pairs(decoded) do
        for _, v in ipairs(versions) do
          table.insert(outputs, {
            name = name,
            version = v.version,
            install_path = v.install_path,
          })
        end
      end
      return outputs
    end,
  })
end

M.kind_name = "file/directory"

local function run_mise(cmd)
  require("cmdhndlr").run({
    name = "cmdhndlr/raw",
    layout = { type = "tab" },
    runner_opts = {
      cmd = cmd,
    },
    hooks = {
      success = require("cmdhndlr.util.hook").echo_success(),
      failure = require("cmdhndlr.util.hook").echo_failure(),
      pre_execute = require("cmdhndlr.util.hook").echo_cmd(),
    },
  })
end

local function run_install(specs, force)
  if #specs == 0 then
    return
  end
  local cmd = { "mise", "install" }
  if force then
    table.insert(cmd, "-f")
  end
  vim.list_extend(cmd, specs)
  run_mise(cmd)
end

M.actions = {
  action_update = function(items)
    local seen = {}
    local specs = {}
    for _, item in ipairs(items) do
      if not seen[item.name] then
        seen[item.name] = true
        table.insert(specs, ("%s@latest"):format(item.name))
      end
    end
    run_install(specs, true)
  end,

  action_install = function(items)
    local specs = vim
      .iter(items)
      :map(function(item)
        return ("%s@%s"):format(item.name, item.version)
      end)
      :totable()
    run_install(specs, false)
  end,

  action_uninstall = function(items)
    local specs = vim
      .iter(items)
      :map(function(item)
        return ("%s@%s"):format(item.name, item.version)
      end)
      :totable()
    if #specs == 0 then
      return
    end
    local cmd = vim.list_extend({ "mise", "uninstall" }, specs)
    run_mise(cmd)
  end,
}

return M
