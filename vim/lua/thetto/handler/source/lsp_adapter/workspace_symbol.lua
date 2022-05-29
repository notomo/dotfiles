local pathlib = require("thetto.lib.path")
local util = require("notomo.plugin.thetto.util")

local M = {}

function M._to_item(_, cwd)
  local to_relative = pathlib.relative_modifier(cwd)
  return function(v)
    local kind = vim.lsp.protocol.SymbolKind[v.kind]
    local path = vim.uri_to_fname(v.location.uri)
    local relative_path = to_relative(path)
    local row = v.location.range.start.line + 1
    local path_row = ("%s:%d"):format(relative_path, row)
    local desc = ("%s %s [%s]"):format(path_row, v.name, kind)
    return {
      path = path,
      row = row,
      column = v.location.range.start.character + 1,
      desc = desc,
      value = v.name,
      kind = kind,
      column_offsets = {
        ["path:relative"] = 0,
        value = #path_row + 1,
        kind = #desc - #kind - 2,
      },
      range = util.range(v.location.range),
    }
  end
end

function M.collect(self, source_ctx)
  local pattern = source_ctx.pattern
  local to_item = self:_to_item(source_ctx.cwd)
  return function(observer)
    local method = "workspace/symbol"
    local params = { query = pattern or "method" }
    vim.lsp.buf_request(self.bufnr, method, params, function(_, result)
      local items = vim.tbl_map(function(e)
        return to_item(e)
      end, result or {})
      observer:next(items)
      observer:complete()
    end)
  end,
    nil,
    self.errors.skip_empty_pattern
end

function M.highlight(self, bufnr, first_line, items)
  local highlighter = self.highlights:create(bufnr)
  for i, item in ipairs(items) do
    highlighter:add("Comment", first_line + i - 1, 0, item.column_offsets.value - 1)
    highlighter:add("Statement", first_line + i - 1, item.column_offsets.kind, -1)
  end
end

M.kind_name = "file"

return M
