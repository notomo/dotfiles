local M = {}

M.opts = {
  from = nil,
}

function M.collect(source_ctx)
  local cmd = { "gh", "retrospect", "--limit=1000" }
  if source_ctx.opts.from then
    vim.list_extend(cmd, { "--from=" .. source_ctx.opts.from })
  end
  return require("thetto.util.job").run(cmd, source_ctx, function(output)
    local label = table.concat(output.label_names, ", ")
    local value = ("%s %s %s"):format(output._type, output.title, label)
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
      vim.list_extend(outputs, decoded.closed_issues)
      vim.list_extend(outputs, decoded.reported_issues)
      vim.list_extend(outputs, decoded.merged_pull_requests)
      vim.list_extend(outputs, decoded.reviewed_pull_requests)
      return outputs
    end,
  })
end

M.kind_name = "url"

return M
