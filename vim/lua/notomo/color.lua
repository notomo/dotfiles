local pallet = require("ultramarine").pallet
vim.api.nvim_set_hl(0, "Flashy", { bold = true, fg = pallet.black, bg = pallet.lightest_blue })
vim.api.nvim_set_hl(0, "YankRoundRegion", { fg = pallet.black, bg = pallet.yellow })
vim.api.nvim_set_hl(0, "ZenSpace", { underline = true, bg = pallet.red })

vim.api.nvim_set_hl(0, "markdownCode", { fg = pallet.yellow })
vim.api.nvim_set_hl(0, "markdownUrl", { fg = pallet.lightest_blue })
vim.api.nvim_set_hl(0, "makeCommands", { fg = pallet.white })

vim.api.nvim_set_hl(0, "helpExample", { fg = pallet.lightest_blue })

vim.api.nvim_set_hl(0, "sqlStatement", { default = true, link = "sqlKeyword" })

vim.api.nvim_set_hl(0, "diffIndexLine", { fg = pallet.white })
vim.api.nvim_set_hl(0, "diffFile", { fg = pallet.red })
vim.api.nvim_set_hl(0, "diffAdded", { fg = pallet.light_green })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = pallet.red })

--for gina status
vim.api.nvim_set_hl(0, "AnsiColor1", { ctermfg = 1, fg = "#ffaaaa" })
vim.api.nvim_set_hl(0, "AnsiColor2", { ctermfg = 2, fg = "#aaddaa" })

vim.api.nvim_set_hl(0, "LspReferenceText", { link = "Search" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Search" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "Todo" })
vim.api.nvim_set_hl(0, "LspCodeLens", { link = "Comment" })
vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { link = "Comment" })

vim.api.nvim_set_hl(0, "SpellCap", { link = "NONE" })

if vim.fn.has("mac") == 1 then
  vim.api.nvim_set_hl(0, "Cursor", { bg = "#bbbbba" })
end

vim.api.nvim_set_hl(0, "OptpackGitCommitLog", { link = "Normal" })
vim.api.nvim_set_hl(0, "OptpackGitCommitRevision", { link = "Label" })
vim.api.nvim_set_hl(0, "OptpackUpdatedRevisionRange", { link = "Label" })

vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { bg = pallet.blue, nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { bg = pallet.dark_blue, nocombine = true })
