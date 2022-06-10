local M = {}

function M.help(bufnr, item)
  local cmd = { "python", "-c", ([[help('%s')]]):format(item.value) }
  local job = require("thetto.lib.job").new(cmd, {
    on_exit = function(job_self)
      local lines = job_self:get_stdout()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end,
    on_stderr = require("thetto.lib.job").print_stderr,
    env = { PAGER = "cat" },
  })
  local err = job:start()
  if err ~= nil then
    return nil, err
  end
  return job, nil
end

function M.action_preview(_, items, ctx)
  local item = items[1]
  if item == nil then
    return
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = "wipe"

  ctx.ui:open_preview(item, { raw_bufnr = bufnr })

  return M.help(bufnr, item)
end

function M.action_show(_, items)
  local item = items[1]
  if item == nil then
    return
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = "wipe"
  vim.cmd([[tabedit | buffer ]] .. bufnr)
  vim.opt_local.list = false

  return M.help(bufnr, item)
end

M.action_tab_open = M.action_show

M.default_action = "show"

return M
