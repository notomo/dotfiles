local M = {}

M.opts = { merged = false }

function M.collect(self, source_ctx)
  local cmd = { "brew", "list", "-1" }
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self)
      local items = {}
      for _, output in ipairs(job_self:get_stdout()) do
        table.insert(items, { value = output })
      end
      self:append(items)
    end,
    on_stderr = self.jobs.print_stderr,
    cwd = source_ctx.cwd,
  })

  return {}, job
end

M.kind_name = "word"

return M
