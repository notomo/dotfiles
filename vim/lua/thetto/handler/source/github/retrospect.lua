local M = {}

local default_days = 14
M.opts = {
  from = tostring(-default_days * 24) .. "h",
}

function M.collect(source_ctx)
  local cmd = { "gh", "retrospect", "--limit=1000" }
  if source_ctx.opts.from then
    vim.list_extend(cmd, { "--from=" .. source_ctx.opts.from })
  end
  return require("thetto.util.job").run(cmd, source_ctx, function(output)
    local label = table.concat(output.label_names, ", ")
    local value = ("%s %s %s %s"):format(output.created_at, output._type, output.title, label)
    return {
      value = value,
      url = output.url,
      retrospect = output,
    }
  end, {
    to_outputs = function(output)
      local decoded = vim.json.decode(output, { luanil = { object = true } })
      vim.iter(decoded):each(function(k, values)
        if type(values) ~= "table" then
          return
        end
        for _, v in ipairs(values) do
          v._type = k
        end
      end)

      local outputs = {}

      local closed_or_reported = {}
      vim.list_extend(closed_or_reported, decoded.closed_issues)
      vim.list_extend(closed_or_reported, decoded.reported_issues)

      vim.list_extend(
        outputs,
        require("misclib.collection.list").unique(closed_or_reported, function(x)
          return x.url
        end)
      )
      vim.list_extend(outputs, decoded.merged_pull_requests)
      vim.list_extend(outputs, decoded.reviewed_pull_requests)
      return outputs
    end,
  })
end

M.kind_name = "url"

M.sorters = { "-numeric:retrospect.created_at" }

return M
