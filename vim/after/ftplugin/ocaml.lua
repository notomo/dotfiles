require("notomo.lsp.mapping").setup()
require("notomo.lsp.autocmd").setup()
vim.b.cmdhndlr_runner_opts = {
  use_in_repl = true,
}
