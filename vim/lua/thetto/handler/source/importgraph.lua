local M = {}

function M.collect(source_ctx)
  local pattern, subscriber = require("thetto.util.source").get_input(source_ctx)
  if not pattern then
    return subscriber
  end

  local filters = vim.tbl_map(function(p)
    if vim.startswith(p, "!") then
      return function(path)
        return not path:match(p:sub(2))
      end
    end
    return function(path)
      return path:match(p)
    end
  end, vim.split(pattern, "%s+"))
  local filter = function(path)
    for _, filter in ipairs(filters) do
      if not filter(path) then
        return false
      end
    end
    return true
  end

  local languages = {
    gomod = "go",
  }
  local filetype = vim.bo[source_ctx.bufnr].filetype
  local language = languages[filetype] or filetype
  if vim.bo[source_ctx.bufnr].buftype == "nofile" then
    language = "lua"
  end

  local graph = require("importgraph").render(language, {
    collector = {
      path_filter = filter,
      imported_target_filter = filter,
      working_dir = source_ctx.cwd,
    },
  })

  local lines = vim.split(graph, "\n", { plain = true })
  return vim.tbl_map(function(line)
    return {
      value = line,
    }
  end, lines)
end

M.kind_name = "word"

M.modify_pipeline = require("thetto.util.pipeline").prepend({
  require("thetto.util.filter").by_name("source_input"),
})

return M
