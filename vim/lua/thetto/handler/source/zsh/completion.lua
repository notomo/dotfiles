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
    return { value = vim.fn.trim(output, 2) }
  end)
end

M.kind_name = "word"

return M
