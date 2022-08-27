local M = {}

function M.action_preview(_, items, ctx)
  local item = items[1]
  if not item then
    return nil
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].filetype = "go"

  local symbol = ("%s.%s"):format(item.package_name, item.method_or_field)
  local cmd = { "go", "doc", symbol }

  local job = require("thetto.lib.job").new(cmd, {
    on_exit = function(job_self)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      local lines = job_self:get_output()
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end,
    on_stderr = require("thetto.lib.job").print_stderr,
  })
  local err = job:start()
  if err ~= nil then
    return nil, err
  end

  ctx.ui:open_preview(item, { raw_bufnr = bufnr })
end

function M.action_open(_, items)
  local item = items[1]
  if not item then
    return nil
  end

  local pattern = ("%s %s"):format(item.reserved_word, item.method_or_field)

  local cmd = { "go", "list", "-f", "{{.Dir}}", item.package_name }
  local dir = vim.fn.systemlist(cmd)[1]
  require("thetto").start("file/grep", {
    opts = {
      input_lines = { pattern },
      insert = false,
      cwd = dir,
      filters = { "interactive", "substring", "-substring", "substring:path:relative", "-substring:path:relative" },
    },
  })
end

M.default_action = "open"

return M
