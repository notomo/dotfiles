local pallet = require("ultramarine").pallet
vim.api.nvim_set_hl(0, "Flashy", { bold = true, fg = pallet.black, bg = pallet.lightest_blue })
vim.api.nvim_set_hl(0, "YankRoundRegion", { fg = pallet.black, bg = pallet.yellow })

vim.api.nvim_set_hl(0, "markdownCode", { fg = pallet.yellow })
vim.api.nvim_set_hl(0, "markdownUrl", { fg = pallet.lightest_blue })
vim.api.nvim_set_hl(0, "makeCommands", { fg = pallet.white })

vim.api.nvim_set_hl(0, "helpExample", { fg = pallet.lightest_blue })

vim.api.nvim_set_hl(0, "sqlStatement", { default = true, link = "sqlKeyword" })

vim.api.nvim_set_hl(0, "diffIndexLine", { fg = pallet.white })
vim.api.nvim_set_hl(0, "diffFile", { fg = pallet.red })
vim.api.nvim_set_hl(0, "diffAdded", { fg = pallet.light_green })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = pallet.red })

vim.api.nvim_set_hl(0, "LspReferenceText", { link = "Search" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Search" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "Todo" })
vim.api.nvim_set_hl(0, "LspCodeLens", { link = "Comment" })
vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { link = "Comment" })
vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })

vim.api.nvim_set_hl(0, "SpellCap", { link = "NONE" })

if vim.fn.has("mac") == 1 then
  vim.api.nvim_set_hl(0, "Cursor", { bg = "#bbbbba" })
end

vim.api.nvim_set_hl(0, "OptpackGitCommitLog", { link = "Normal" })
vim.api.nvim_set_hl(0, "OptpackGitCommitRevision", { link = "Label" })
vim.api.nvim_set_hl(0, "OptpackUpdatedRevisionRange", { link = "Label" })

vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { bg = pallet.blue, nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { bg = pallet.dark_blue, nocombine = true })

vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Keyword" })

vim.api.nvim_set_hl(0, "TermnaviLine", { bg = "#002b6f", bold = true })
vim.api.nvim_set_hl(0, "WinbarNavic", { bg = pallet.blue, fg = "#d1d1f0", underline = true })

vim.api.nvim_set_hl(0, "Operator", { link = "Conditional" })

vim.api.nvim_set_hl(0, "@type.go", {})
vim.api.nvim_set_hl(0, "@type.definition.go", {})
vim.api.nvim_set_hl(0, "@property.go", {})
vim.api.nvim_set_hl(0, "@function.go", {})
vim.api.nvim_set_hl(0, "@function.call.go", {})
vim.api.nvim_set_hl(0, "@method.go", {})
vim.api.nvim_set_hl(0, "@method.call.go", {})
vim.api.nvim_set_hl(0, "@variable.go", {})
vim.api.nvim_set_hl(0, "@parameter.go", {})
vim.api.nvim_set_hl(0, "@field.go", {})
vim.api.nvim_set_hl(0, "@punctuation.delimiter.go", {})
vim.api.nvim_set_hl(0, "@punctuation.bracket.go", {})
vim.api.nvim_set_hl(0, "@function.builtin.go", { link = "Function" })
vim.api.nvim_set_hl(0, "@keyword.return.go", { link = "Statement" })
vim.api.nvim_set_hl(0, "@constant.builtin.go", { link = "Constant" })
vim.api.nvim_set_hl(0, "@constant.go", {})
vim.api.nvim_set_hl(0, "@keyword.operator.go", { link = "Operator" })
vim.api.nvim_set_hl(0, "@namespace.go", {})
vim.api.nvim_set_hl(0, "@include.go", { link = "Conditional" })

vim.api.nvim_set_hl(0, "@variable.lua", {})
vim.api.nvim_set_hl(0, "@variable.member.lua", {})
vim.api.nvim_set_hl(0, "@variable.parameter.lua", {})
vim.api.nvim_set_hl(0, "@parameter.lua", {})
vim.api.nvim_set_hl(0, "@field.lua", {})
vim.api.nvim_set_hl(0, "@punctuation.delimiter.lua", {})
vim.api.nvim_set_hl(0, "@punctuation.bracket.lua", {})
vim.api.nvim_set_hl(0, "@function.builtin.lua", { link = "Function" })
vim.api.nvim_set_hl(0, "@keyword.return.lua", { link = "Statement" })
vim.api.nvim_set_hl(0, "@constant.builtin.lua", { link = "Constant" })
vim.api.nvim_set_hl(0, "@constant.lua", {})
vim.api.nvim_set_hl(0, "@keyword.lua", { link = "Conditional" })
vim.api.nvim_set_hl(0, "@local.lua", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@keyword.operator.lua", { link = "Operator" })
vim.api.nvim_set_hl(0, "@keyword.conditional.lua", { link = "Conditional" })
vim.api.nvim_set_hl(0, "@keyword.repeat.lua", { link = "Repeat" })
vim.api.nvim_set_hl(0, "@text.literal.block.markdown", {})
vim.api.nvim_set_hl(0, "@text.literal.markdown_inline", { link = "Conditional" })
vim.api.nvim_set_hl(0, "@text.literal.vimdoc", {})
vim.api.nvim_set_hl(0, "@text.literal.block.vimdoc", {})
vim.api.nvim_set_hl(0, "@label.vimdoc", { link = "String" })
vim.api.nvim_set_hl(0, "@string.yaml", {})
vim.api.nvim_set_hl(0, "@function.call.bash", {})
vim.api.nvim_set_hl(0, "@parameter.bash", {})
vim.api.nvim_set_hl(0, "@constant.bash", {})
vim.api.nvim_set_hl(0, "@variable.bash", {})
vim.api.nvim_set_hl(0, "@punctuation.special.bash", {})
vim.api.nvim_set_hl(0, "@punctuation.bracket.bash", {})
vim.api.nvim_set_hl(0, "@type.typescript", { link = "Normal" })
vim.api.nvim_set_hl(0, "@constant.typescript", {})

vim.api.nvim_set_hl(0, "@text.note", { link = "Todo" })

local Decorator = require("misclib.decorator")
local decorators = {}
local ns = vim.api.nvim_create_namespace("notomo_whitespace")
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = vim.api.nvim_create_augroup("notomo_whitespace", {}),
  pattern = { "*" },
  callback = function(args)
    decorators[args.buf] = Decorator.new(ns, args.buf, true)
  end,
})
local regex = vim.regex([[\v　+]])
vim.api.nvim_set_decoration_provider(ns, {})
vim.api.nvim_set_decoration_provider(ns, {
  on_win = function(_, _, bufnr)
    return decorators[bufnr] ~= nil
  end,
  on_line = function(_, _, bufnr, row)
    local index = 0
    local max_row = vim.api.nvim_buf_line_count(bufnr) - 1
    if max_row < row then
      return true
    end
    for _ = 0, 100, 1 do
      local s, e = regex:match_line(bufnr, row, index)
      if not s then
        return true
      end
      local decorator = decorators[bufnr]
      decorator:highlight("Todo", row, index + s, index + e)
      index = index + e
    end
    return true
  end,
})

local hl_groups = require("ultramarine").highlight_groups
vim.api.nvim_set_hl(0, "NormalCursorLineNr", hl_groups.CursorLineNr)
vim.api.nvim_set_hl(0, "VisualCursorLineNr", { fg = pallet.white, bg = pallet.green, bold = true })

local group = vim.api.nvim_create_augroup("notomo_mode_color", {})
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
  group = group,
  pattern = { [=[*:[vV\x16]]=] },
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLineNr", { link = "VisualCursorLineNr" })
  end,
})
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
  group = group,
  pattern = { [=[*:n]=], [=[*:nt]=] },
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLineNr", { link = "NormalCursorLineNr" })
  end,
})
