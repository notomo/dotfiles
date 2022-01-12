vim.g.yankround_use_region_hl = 1
vim.keymap.set({ "n", "x" }, "p", [[<Plug>(yankround-p)]])
vim.keymap.set("n", "P", [[<Plug>(yankround-P)]])
vim.keymap.set("n", "<C-p>", [[<Plug>(yankround-prev)]])
vim.keymap.set("n", "<C-n>", [[<Plug>(yankround-next)]])
