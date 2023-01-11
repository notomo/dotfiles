require("notomo.lsp.mapping").setup()
require("notomo.lsp.autocmd").setup()
local use_dune_top = vim.fs.find("dune-project", { upward = true, type = "file" })[1] ~= nil
vim.b.cmdhndlr_runner_opts = {
  use_in_repl = true,
  use_dune_top = use_dune_top,
}
