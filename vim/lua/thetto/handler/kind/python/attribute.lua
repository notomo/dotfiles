local M = {}

function M.help(bufnr, item)
  local cmd = { "python", "-c", ([[help('%s')]]):format(item.value) }
  return require("thetto.util.job").execute(cmd, {
    on_exit = function(job_self)
      local lines = job_self:get_stdout()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end,
    env = { PAGER = "cat" },
  })
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
  vim.cmd.tabedit()
  vim.cmd.buffer({ count = bufnr })
  vim.opt_local.list = false

  return M.help(bufnr, item)
end

M.action_tab_open = M.action_show

M.default_action = "show"

return M
