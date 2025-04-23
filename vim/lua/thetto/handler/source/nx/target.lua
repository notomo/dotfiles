local M = {}

M.opts = {
  project_name = "",
}

function M.collect(source_ctx)
  local cmd = {
    "npx",
    "nx",
    "show",
    "project",
    source_ctx.opts.project_name,
    "--json",
  }
  return require("thetto.util.job").run(cmd, source_ctx, function(target)
    return {
      value = target,
      project_name = source_ctx.opts.project_name,
      cwd = source_ctx.cwd,
    }
  end, {
    to_outputs = function(output)
      return vim.json.decode(output, { luanil = { object = true } }).targets
    end,
  })
end

M.kind_name = "word"

M.cwd = require("thetto.util.cwd").upward({ ".git" })

M.actions = {
  action_execute = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdhndlr").run({
      name = "cmdhndlr/raw",
      working_dir = function()
        return item.cwd
      end,
      layout = { type = "tab" },
      runner_opts = {
        cmd = {
          "npx",
          "nx",
          item.value,
          item.project_name,
        },
      },
      hooks = {
        success = require("cmdhndlr.util.hook").echo_success(),
        failure = require("cmdhndlr.util.hook").echo_failure(),
        pre_execute = require("cmdhndlr.util.hook").echo_cmd(),
      },
    })
  end,
  default_action = "execute",
}

return M
