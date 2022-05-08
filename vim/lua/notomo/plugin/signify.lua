vim.keymap.set("n", "[git]j", [[<Plug>(signify-next-hunk)zz]])
vim.keymap.set("n", "[git]k", [[<Plug>(signify-prev-hunk)zz]])
vim.keymap.set("n", "[git]t", [[<Cmd>SignifyToggle<CR>]])
vim.g.signify_disable_by_default = 0
vim.g.signify_skip = {
  vcs = { deny = { "yadm", "hg", "svn", "bzr", "darcs", "fossil", "cvs", "rcs", "accurev", "perforce", "tfs" } },
}
