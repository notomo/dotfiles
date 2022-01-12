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
