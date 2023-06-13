local M = {}

M.opts = {
  project_url = "",
  limit = 50,
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
    local value = item.content.title
    return {
      value = value,
      url = item.content.url,
    }
  end, {
    to_outputs = function(output)
      return vim.json.decode(output, { luanil = { object = true } })
    end,
  })
end

M.kind_name = "url"

return M
