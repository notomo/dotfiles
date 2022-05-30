local pathlib = require("thetto.lib.path")
local util = require("notomo.plugin.thetto.util")

local M = {}

function M.request(bufnr, method)
  local params = vim.lsp.util.make_position_params()
  return require("promise").new(function(resolve, reject)
    vim.lsp.buf_request(bufnr, "textDocument/prepareCallHierarchy", params, function(err, result, ctx)
      if err then
        return reject(err)
      end

      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if not client then
        return reject(err)
      end
      return resolve(client, result[1])
    end)
  end):next(function(client, call_hierarchy_item)
    return require("promise").new(function(resolve, reject)
      client.request(method, { item = call_hierarchy_item }, function(err, result)
        if err then
          return reject(err)
        end
        return resolve(result)
      end, bufnr)
    end)
  end)
end

function M.collect(self, opts)
  return function(observer)
    return M.request(self.bufnr, "callHierarchy/outgoingCalls")
      :next(function(result)
        local to_relative = pathlib.relative_modifier(opts.cwd)
        local path = vim.api.nvim_buf_get_name(self.bufnr)
        local relative_path = to_relative(path)

        local items = {}
        for _, call in pairs(result or {}) do
          local call_hierarchy = call["to"]
          for _, range in pairs(call.fromRanges) do
            local row = range.start.line + 1
            local value = call_hierarchy.name
            local path_with_row = ("%s:%d"):format(relative_path, row)
            table.insert(items, {
              path = path,
              desc = ("%s %s()"):format(path_with_row, value),
              value = value,
              row = row,
              range = util.range(range),
              column_offsets = {
                ["path:relative"] = 0,
                value = #path_with_row + 1,
              },
            })
          end
        end
        observer:next(items)
        observer:complete()
      end)
      :catch(function(err)
        observer:error(err)
      end)
  end
end

M.highlight = require("thetto.util").highlight.columns({
  {
    group = "Comment",
    end_key = "value",
  },
})

M.kind_name = "file"
M.sorters = { "row" }

return M
