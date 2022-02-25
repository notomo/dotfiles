local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.actionlint,
  },
  should_attach = function(bufnr)
    return vim.api.nvim_buf_get_name(bufnr):match("/%.github/")
  end,
})
