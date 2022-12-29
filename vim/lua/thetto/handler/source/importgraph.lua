local M = {}

function M.collect(source_ctx)
  local pattern = source_ctx.pattern or ""

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

  local graph = require("importgraph").render({
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

return M
