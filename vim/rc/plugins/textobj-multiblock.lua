vim.g.textobj_multiblock_no_default_key_mappings = 1
vim.keymap.set({ "o", "x" }, "aj", [[<Plug>(textobj-multiblock-a)]])
vim.keymap.set({ "o", "x" }, "ij", [[<Plug>(textobj-multiblock-i)]])
vim.g.textobj_multiblock_blocks = {
  { "(", ")" },
  { "[", "]" },
  { "{", "}" },
  { "<", ">" },
  { '"', '"' },
  { "'", "'" },
  { "`", "`", 1 },
}
