local M = {}

M.opts = {owner = ":owner", repo = ":repo"}

function M.collect(self, opts)
  local cmd = {
    "gh",
    "api",
    "-X",
    "GET",
    ("repos/%s/%s/pulls"):format(self.opts.owner, self.opts.repo),
    "-F",
    "per_page=100",
  }
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self, code)
      if code ~= 0 then
        return
      end

      local items = {}
      local prs = vim.fn.json_decode(job_self:get_stdout())
      for _, pr in ipairs(prs) do
        local mark
        if pr.draft then
          mark = "D"
        else
          mark = "R"
        end
        local title = ("%s %s"):format(mark, pr.title)
        local at = "" .. pr.created_at
        local by = "by " .. pr.user.login
        local desc = ("%s %s %s"):format(title, at, by)
        table.insert(items, {
          value = pr.title,
          url = pr.html_url,
          desc = desc,
          pr = {is_draft = pr.draft},
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
    if not item.pr.is_draft then
      highlighter:add("Character", first_line + i - 1, 0, 1)
    else
      highlighter:add("Comment", first_line + i - 1, 0, 1)
    end
    highlighter:add("Comment", first_line + i - 1, item.column_offsets.at, item.column_offsets.by)
  end
end

M.kind_name = "word"

return M
