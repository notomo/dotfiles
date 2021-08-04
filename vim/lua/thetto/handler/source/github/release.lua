local M = {}

M.opts = {owner = ":owner", repo = ":repo"}

function M.collect(self, opts)
  local cmd = {
    "gh",
    "api",
    "-X",
    "GET",
    ("repos/%s/%s/releases"):format(self.opts.owner, self.opts.repo),
    "-F",
    "per_page=100",
  }
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self, code)
      if code ~= 0 then
        return
      end

      local items = {}
      local releases = vim.fn.json_decode(job_self:get_stdout())
      for _, release in ipairs(releases) do
        local mark
        if release.draft then
          mark = "D"
        else
          mark = "R"
        end
        local title = ("%s %s"):format(mark, release.name)
        local desc = title
        table.insert(items, {
          value = release.name,
          url = release.html_url,
          desc = desc,
          release = {is_draft = release.draft},
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
    if item.release.is_draft then
      highlighter:add("Comment", first_line + i - 1, 0, 1)
    else
      highlighter:add("Character", first_line + i - 1, 0, 1)
    end
  end
end

M.kind_name = "word"

return M
