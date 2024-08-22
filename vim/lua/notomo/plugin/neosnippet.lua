vim.keymap.set("x", "<Space>S", [[<Plug>(neosnippet_expand_target)]])
vim.keymap.set("n", "[file]s", [[<Cmd>NeoSnippetEdit<CR>]])
vim.g["neosnippet#snippets_directory"] = vim.fs.joinpath(tostring(vim.fn.stdpath("config")), "snippets")
vim.g["neosnippet#disable_runtime_snippets"] = { ["_"] = 1 }
