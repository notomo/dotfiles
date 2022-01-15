vim.keymap.set("n", "J", [[<Cmd>lua require("notomo.json").next()<CR>]], { buffer = true })
vim.keymap.set("n", "K", [[<Cmd>lua require("notomo.json").prev()<CR>]], { buffer = true })
