require("nvim-treesitter.configs").setup({
  textobjects = {
    move = {
      enable = true,
      set_jumps = false,
      goto_next_start = {},
      goto_next_end = {},
      goto_previous_start = {},
      goto_previous_end = {},
    },
  },
})
