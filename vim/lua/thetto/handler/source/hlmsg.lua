local M = {}

function M.collect()
  local items = {}
  for _, chunk in ipairs(require("hlmsg").get()) do
    local texts = {}
    local highlights = {}
    local start_col = 0
    for _, pair in ipairs(chunk) do
      local text, hl_group = unpack(pair)
      local end_col = start_col + vim.fn.strdisplaywidth(text)
      table.insert(texts, text)
      table.insert(highlights, {
        group = hl_group or "Normal",
        start_col = start_col,
        end_col = end_col,
      })
    end
    local value = table.concat(texts, "")
    table.insert(items, {
      value = value,
      highlights = highlights,
    })
  end
  return items
end

M.kind_name = "word"

function M.highlight(highlighter, items, first_line)
  for i, item in ipairs(items) do
    for _, highlight in ipairs(item.highlights) do
      highlighter:add(highlight.group, first_line + i - 1, highlight.start_col, highlight.end_col)
    end
  end
end

return M
