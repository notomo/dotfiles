local M = {}

M.collect = function(self, opts)
  local cmd = {"vusted", "-l", "-o", "TAP", "--pattern", vim.fn.expand("%:t:r"), "test"}
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self)
      local items = {}
      for _, output in ipairs(job_self:get_stderr()) do
        local path, row, matched_line = self.pathlib.parse_with_row(output)
        if path == nil then
          goto continue
        end
        table.insert(items, {
          value = vim.trim(matched_line),
          path = ("%s/%s"):format(opts.cwd, path),
          row = row,
        })
      end
      self.append(items)
      ::continue::
    end,
    cwd = opts.cwd,
  })
  return {}, job
end

M.kind_name = "file"

return M
