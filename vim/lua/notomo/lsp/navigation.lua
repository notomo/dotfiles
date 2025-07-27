local M = {}

M.filetypes = {
  go = true,
  typescript = true,
  typescriptreact = true,
  c = true,
  terraform = true,
}

function M.attach(client, bufnr)
  local filetype = vim.bo[bufnr].filetype
  if M.filetypes[filetype] and client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

local function setup_stlparts()
  local join_by = require("misclib.collection.list").join_by
  local stlparts = require("stlparts")
  local C = stlparts.component
  local Builder = C.builder
  local Highlight = C.highlight
  local DefaultHighlight = C.default_highlight

  local no_scope = Highlight("WinbarNavic", "(no scope)")
  local separator = Highlight("WinbarNavicSeparator", " > ")

  local ignore_types = {
    "Variable",
  }
  stlparts.set("navic", {
    DefaultHighlight("Normal", {
      Highlight("WinbarNavicSeparator", " > "),
      Builder(function(ctx)
        local bufnr = vim.api.nvim_win_get_buf(ctx.window_id)
        local navic = require("nvim-navic")
        if not navic.is_available(bufnr) then
          return ""
        end
        local data = navic.get_data(bufnr)
        if not data or #data == 0 then
          return no_scope
        end
        local names = vim
          .iter(data)
          :filter(function(d)
            return not vim.tbl_contains(ignore_types, d.type)
          end)
          :map(function(d)
            return Highlight("WinbarNavic", d.name)
          end)
          :totable()
        return join_by(names, separator)
      end),
      " ",
    }),
  })
end

function M.setup()
  local filetype = vim.bo.filetype
  if not M.filetypes[filetype] then
    return
  end

  setup_stlparts()

  local window_id = vim.api.nvim_get_current_win()
  if not require("misclib.window").is_floating(window_id) then
    vim.wo[window_id].winbar = [[%!v:lua.require("stlparts").build("navic")]]
  end
end

return M
