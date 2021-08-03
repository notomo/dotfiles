local M = {}

function M.collect(self, opts)
  local cmd = {"gh", "api", "-X", "GET", "repos/:owner/:repo/issues", "-F", "per_page=100"}
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self, code)
      if code ~= 0 then
        return
      end

      local items = {}
      local issues = vim.fn.json_decode(job_self:get_stdout())
      for _, issue in ipairs(issues) do
        local mark
        if issue.state == "open" then
          mark = "O"
        else
          mark = "C"
        end
        local title = ("%s %s"):format(mark, issue.title)
        local at = "" .. issue.created_at
        local by = "by " .. issue.user.login
        local desc = ("%s %s %s"):format(title, at, by)
        table.insert(items, {
          value = issue.title,
          url = issue.html_url,
          desc = desc,
          issue = {is_opened = issue.state == "open"},
          column_offsets = {value = #mark + 1, at = #title + 1, by = #title + #at + 1},
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
    if item.issue.is_opened then
      highlighter:add("Character", first_line + i - 1, 0, 1)
    else
      highlighter:add("Boolean", first_line + i - 1, 0, 1)
    end
    highlighter:add("Comment", first_line + i - 1, item.column_offsets.at, item.column_offsets.by)
  end
end

M.kind_name = "word"

return M
