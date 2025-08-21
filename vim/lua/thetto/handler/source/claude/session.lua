local M = {}

function M.collect()
  return vim
    .iter(require("notomo.lib.claude").get_sessions())
    :map(function(session)
      local first_message = session.head_messages[1] or ""
      return {
        value = first_message:gsub("\n", " "),
        session_id = session.session_id,
        head_messages = session.head_messages,
      }
    end)
    :totable()
end

M.kind_name = "word"

local get_lines = function(item)
  return vim
    .iter(item.head_messages)
    :map(function(message)
      local message_lines = vim.split(message, "\n", { plain = true })
      table.insert(message_lines, "")
      table.insert(message_lines, ("-"):rep(50))
      table.insert(message_lines, "")
      return message_lines
    end)
    :flatten()
    :totable()
end

M.actions = {
  action_resume = function(items)
    local item = items[1]
    if item == nil then
      return
    end

    local git_root = vim.fs.root(0, ".git")
    if not git_root then
      return
    end

    vim.cmd.tabedit()
    vim.fn.jobstart({ "claude", "--resume", item.session_id }, {
      term = true,
      cwd = git_root,
    })
  end,

  action_tab_open = function(items)
    for _, item in ipairs(items) do
      local bufnr = vim.api.nvim_create_buf(false, true)
      local lines = get_lines(item)
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

      vim.cmd.tabedit()
      vim.cmd.buffer(bufnr)
    end
  end,

  get_preview = function(item)
    return nil, {
      lines = get_lines(item),
      wrap = true,
    }
  end,
  default_action = "resume",
}

return M