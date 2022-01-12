vim.keymap.set({ "o", "x" }, "i.", [[textobj#from_regexp#mapexpr('\.\zs.\{-}\ze\.')]], { expr = true })
vim.keymap.set({ "o", "x" }, "a.", [[textobj#from_regexp#mapexpr('\..\{-1,}\(\.\)\@=')]], { expr = true })

vim.keymap.set({ "o", "x" }, "ix", [[textobj#from_regexp#mapexpr('\v\*\zs[^*]+\ze\*')]], { expr = true })
vim.keymap.set({ "o", "x" }, "ax", [[textobj#from_regexp#mapexpr('\*.\{-1,}\(*\)\@=')]], { expr = true })

vim.keymap.set({ "o", "x" }, "i/", [[textobj#from_regexp#mapexpr('/\zs.\{-}\ze/')]], { expr = true })
vim.keymap.set({ "o", "x" }, "a/", [[textobj#from_regexp#mapexpr('/.\{-1,}\(/\)\@=')]], { expr = true })
