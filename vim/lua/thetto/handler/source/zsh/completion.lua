local M = {}

function M.collect(_, source_ctx)
  local pattern = source_ctx.pattern
  if not source_ctx.interactive and not pattern then
    pattern = vim.fn.input("Pattern: ")
  end
  if not pattern or pattern == "" then
    return function(observer)
      observer:complete()
    end
  end

  local cmd = { "capture.zsh", pattern }
  return require("thetto.util").job.start(cmd, source_ctx, function(output)
    local desc = vim.fn.trim(output, 2)
    local value = vim.split(desc, "%s+")[1]
    return {
      value = value,
      desc = desc,
      column_offsets = {
        value = 0,
        desc = #value,
      },
    }
  end)
end

M.highlight = require("thetto.util").highlight.columns({
  {
    group = "Comment",
    start_key = "desc",
  },
})

M.kind_name = "word"

return M
