require("multito.copilot").config()

local group = vim.api.nvim_create_augroup("notomo.multito", {})

local set_winbar = function()
  local stlparts = require("stlparts")
  local C = stlparts.component
  local Builder = C.builder
  local Highlight = C.highlight
  local DefaultHighlight = C.default_highlight

  stlparts.set("multito.copilot.panel", {
    DefaultHighlight("Normal", {
      C.separate({
        Highlight("Normal", ""),
        Builder(function(ctx)
          local bufnr = vim.api.nvim_win_get_buf(ctx.window_id)
          local panel = require("multito.copilot").panel_get({ bufnr = bufnr })
          if not panel then
            return ""
          end
          local content = (" [%s / %s] %s"):format(panel.current_index, #panel.items, panel.done and "" or "...")
          return Highlight("Normal", content)
        end),
      }),
    }),
  })
end
set_winbar()

vim.api.nvim_create_autocmd({ "User" }, {
  group = group,
  pattern = { "MultitoCopilotPanelOpened" },
  callback = function()
    vim.keymap.set("n", "<C-n>", function()
      require("multito.copilot").panel_show_item({ offset = 1 })
    end, { buffer = true })
    vim.keymap.set("n", "<C-p>", function()
      require("multito.copilot").panel_show_item({ offset = -1 })
    end, { buffer = true })
    vim.keymap.set("n", "O", function()
      require("multito.copilot").panel_accept()
    end, { buffer = true })

    vim.wo.winbar = [[%!v:lua.require("stlparts").build("multito.copilot.panel")]]
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  group = group,
  pattern = {
    "MultitoCopilotPanelItemShown",
    "MultitoCopilotPanelDone",
  },
  callback = function()
    vim.api.nvim__redraw({ winbar = true })
  end,
})
