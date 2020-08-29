local M = {}

M.range = function(range)
  return {
    s = {row = range.start.line, column = range.start.character},
    e = {row = range["end"].line, column = range["end"].character},
  }
end

return M
