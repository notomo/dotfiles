local M = {}

function M.collect(source_ctx)
  local snippets = require("notomo.lib.snippet").get_snippets(source_ctx.bufnr)

  local items = {}
  for name, snippet in pairs(snippets) do
    local body = snippet.body:sub(-1) == "\n" and snippet.body:sub(1, -2) or snippet.body
    items[#items + 1] = {
      value = name,
      body = body,
      original_item = { body = body },
    }
  end
  return items
end

function M.resolve(params, _, offset)
  require("notomo.lib.snippet").expand(params.body, offset)
end

M.kind_name = "word"
M.kind_label = "Snippet"

M.min_trigger_length = 1

return M
