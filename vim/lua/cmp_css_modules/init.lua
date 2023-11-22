local kind = require("cmp").lsp.CompletionItemKind.Field

local Source = {}

function Source.new()
  return setmetatable({}, { __index = Source })
end

function Source:is_available()
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.bo[bufnr].filetype == "typescriptreact"
end

function Source:get_debug_name()
  return "css_modules"
end

function Source:complete(_, callback)
  require("notomo.lib.cssmodules").symbols():next(function(symbols)
    local items = vim.tbl_map(function(s)
      return {
        label = s.name,
        kind = kind,
      }
    end, symbols)
    callback(items)
  end)
end

return Source
