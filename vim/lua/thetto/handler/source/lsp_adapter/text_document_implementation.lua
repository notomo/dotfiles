local pathlib = require("thetto.lib.path")
local util = require("notomo.plugin.thetto.util")

local M = {}

function M._to_item(_, cwd)
  local to_relative = pathlib.relative_modifier(cwd)
  return function(v)
    local path = vim.uri_to_fname(v.uri)
    local relative_path = to_relative(path)
    local row = v.range.start.line + 1
    return {
      value = ("%s:%d"):format(relative_path, row),
      path = path,
      row = row,
      range = util.range(v.range),
    }
  end
end

function M.collect(self, source_ctx)
  local to_item = self:_to_item(source_ctx.cwd)
  return function(observer)
    local method = "textDocument/implementation"
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(self.bufnr, method, params, function(_, result)
      local items = vim.tbl_map(function(e)
        return to_item(e)
      end, result or {})
      observer:next(items)
      observer:complete()
    end)
  end
end

M.kind_name = "file"

return M
