local pathlib = require("thetto.lib.path")
local util = require("notomo.plugin.thetto.util")

local M = {}

function M.collect(self, opts)
  return function(observer)
    return require("thetto.handler.source.lsp_adapter.outgoing_calls").request(
      self.bufnr,
      "callHierarchy/incomingCalls"
    )
      :next(function(result)
        local to_relative = pathlib.relative_modifier(opts.cwd)

        local items = {}
        for _, call in pairs(result or {}) do
          local call_hierarchy = call["from"]
          for _, range in pairs(call.fromRanges) do
            local path = vim.uri_to_fname(call_hierarchy.uri)
            local relative_path = to_relative(path)
            local row = range.start.line + 1
            local value = call_hierarchy.name
            local path_with_row = ("%s:%d"):format(relative_path, row)
            table.insert(items, {
              path = path,
              desc = ("%s %s()"):format(path_with_row, call_hierarchy.name),
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
