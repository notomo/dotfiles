vim.keymap.set("n", "[keyword]T", [[<Cmd>Translate<CR>]])
vim.keymap.set("x", "T", [[<Plug>TranslateV]])
vim.g.translator_target_lang = "ja"
vim.g.translator_default_engines = { "google" }
vim.g.translator_history_enable = 1
