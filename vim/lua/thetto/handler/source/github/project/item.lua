local M = {}

M.opts = {
  project_url = "",
  limit = 30,
  page_limit = 1,
  query = [[.[] | select(.fieldValues.nodes|any(.field.name == "Status" and .name == "Todo"))]],
}

function M.collect(source_ctx)
  local cmd = {
    "gh",
    "project-item-list",
    "-project-url=" .. source_ctx.opts.project_url,
    "-limit=" .. tostring(source_ctx.opts.limit),
    "-page-limit=" .. tostring(source_ctx.opts.page_limit),
    "-jq=" .. source_ctx.opts.query,
  }
  return require("thetto.util.job").run(cmd, source_ctx, function(item)
    local mark = "O"
    local is_opened = item.content.state ~= "CLOSED"
    if not is_opened then
      mark = "C"
    end

    local value = ("%s %s"):format(mark, item.content.title)
    return {
      value = value,
      url = item.content.url,
      content = {
        is_opened = is_opened,
        updated_at = item.content.updatedAt,
      },
    }
  end, {
    to_outputs = function(output)
      return vim.json.decode(output, { luanil = { object = true } })
    end,
  })
end

M.kind_name = "github/issue"

M.highlight = require("thetto.util.highlight").columns({
  {
    group = "Character",
    else_group = "Boolean",
    end_column = 1,
    filter = function(item)
      return item.content.is_opened
    end,
  },
})

M.sorters = { "-boolean:content.is_opened", "-numeric:content.updated_at" }

return M
