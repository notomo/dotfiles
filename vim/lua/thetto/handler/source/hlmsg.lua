local M = {}

function M.collect()
  local messages = require("hlmsg").get()
  return vim
    .iter(messages)
    :map(function(message)
      return {
        value = message.line,
        chunks = message.chunks,
        message_kind = message.kind,
      }
    end)
    :totable()
end

M.kind_name = "word"

function M.highlight(decorator, items, first_line)
  for i, item in ipairs(items) do
    for _, chunk in ipairs(item.chunks) do
      decorator:highlight(chunk.hl_group, first_line + i - 1, chunk.start_col, chunk.end_col)
    end
  end
end

return M
