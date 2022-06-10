local M = {}

function M.action_show(self, items)
  local item = items[1]
  if item == nil then
    return
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = "wipe"
  vim.cmd([[tabedit | buffer ]] .. bufnr)
  vim.opt_local.list = false

  local cmd = { "python", "-c", ([[help('%s')]]):format(item.value) }
  local job = self.jobs.new(cmd, {
    on_exit = function(job_self)
      local lines = job_self:get_stdout()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end,
    on_stderr = self.jobs.print_stderr,
    env = { PAGER = "cat" },
  })
  local err = job:start()
  if err ~= nil then
    return nil, err
  end
  return job, nil
end

M.action_tab_open = M.action_show

function M.action_search(_, items)
  for _, item in ipairs(items) do
    vim.cmd([[OpenBrowserSearch -python ]] .. item.value)
  end
end

M.default_action = "show"

return M
