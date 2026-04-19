local M = {}

function M.collect()
  local items = require("clpb").list()
  return vim
    .iter(items)
    :map(function(item)
      local value = table.concat(item.lines, "\\n")
      return {
        value = value,
      }
    end)
    :totable()
end

M.kind_name = "word"

return M
