local M = {}

function M.collect(source_ctx)
  local cmd = {
    "npx",
    "nx",
    "show",
    "projects",
    "--json",
  }
  return require("thetto.util.job").run(cmd, source_ctx, function(project_name)
    return {
      value = project_name,
    }
  end, {
    to_outputs = function(output)
      return vim.json.decode(output, { luanil = { object = true } })
    end,
  })
end

M.kind_name = "word"

M.actions = {
  action_list_children = function(items)
    local item = items[1]
    if not item then
      return nil
    end
    local source = require("thetto.util.source").by_name("nx/target", {
      cwd = item.git_root,
      opts = {
        project_name = item.value,
      },
    })
    return require("thetto").start(source)
  end,
  default_action = "list_children",
}

M.cwd = require("thetto.util.cwd").upward({ ".git" })

return M
