local M = {}

function M.range(range)
  if not range then
    return nil
  end
  return {
    s = { row = range.start.line, column = range.start.character },
    e = { row = range["end"].line, column = range["end"].character },
  }
end

return M
