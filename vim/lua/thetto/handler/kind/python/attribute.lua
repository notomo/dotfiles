local M = {}

function M.help(bufnr, item)
  local cmd = { "python", "-c", ([[help('%s')]]):format(item.value) }
  return require("thetto.util.job")
    .promise(cmd, {
      env = { PAGER = "cat" },
      on_exit = function() end,
    })
    :next(function(output)
      local lines = vim.split(output, "\n", { plain = true })
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end)
end

function M.action_preview(items, _, ctx)
  local item = items[1]
  if item == nil then
    return
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = "wipe"

  ctx.ui:open_preview(item, { raw_bufnr = bufnr })

  return M.help(bufnr, item)
end

function M.action_show(items)
  local item = items[1]
  if item == nil then
    return
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = "wipe"
  vim.cmd.tabedit()
  vim.cmd.buffer(bufnr)
  vim.opt_local.list = false

  return M.help(bufnr, item)
end

M.action_tab_open = M.action_show

M.default_action = "show"

return M
