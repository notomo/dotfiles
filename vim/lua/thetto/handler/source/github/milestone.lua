local M = {}

function M.collect(self, opts)
  local cmd = {
    "gh",
    "api",
    "-X",
    "GET",
    "repos/:owner/:repo/milestones",
    "-F",
    "per_page=100",
    "-F",
    "state=all",
  }
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self, code)
      if code ~= 0 then
        return
      end

      local items = {}
      local milestones = vim.fn.json_decode(job_self:get_stdout())
      for _, milestone in ipairs(milestones) do
        local mark
        if milestone.state == "open" then
          mark = "O"
        else
          mark = "C"
        end
        local title = ("%s %s"):format(mark, milestone.title)
        local desc = title
        table.insert(items, {
          value = milestone.title,
          url = milestone.html_url,
          desc = desc,
          milestone = {is_opened = milestone.state == "open"},
          column_offsets = {value = #mark + 1},
        })
      end
      self:append(items)
    end,
    on_stderr = self.jobs.print_stderr,
    cwd = opts.cwd,
  })
  return {}, job
end

function M.highlight(self, bufnr, first_line, items)
  local highlighter = self.highlights:create(bufnr)
  for i, item in ipairs(items) do
    if item.milestone.is_opened then
      highlighter:add("Character", first_line + i - 1, 0, 1)
    else
      highlighter:add("Boolean", first_line + i - 1, 0, 1)
    end
  end
end

M.kind_name = "word"

return M
