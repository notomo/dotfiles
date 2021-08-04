local M = {}

M.opts = {user_name = ":owner"}

function M.collect(self, opts)
  local cmd = {
    "gh",
    "api",
    "-X",
    "GET",
    ("users/%s/repos"):format(self.opts.user_name),
    "-F",
    "per_page=100",
    "-F",
    "sort=updated",
  }
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self, code)
      if code ~= 0 then
        return
      end

      local items = {}
      local repos = vim.fn.json_decode(job_self:get_stdout())
      for _, repo in ipairs(repos) do
        local mark
        if repo.archived then
          mark = "A"
        else
          mark = " "
        end
        local title = ("%s %s"):format(mark, repo.full_name)
        local desc = title
        table.insert(items, {
          value = repo.full_name,
          url = repo.html_url,
          desc = desc,
          repo = {is_archived = repo.archived},
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
    if item.repo.is_archived then
      highlighter:add("Comment", first_line + i - 1, 0, 1)
    end
  end
end

M.kind_name = "word"

return M
