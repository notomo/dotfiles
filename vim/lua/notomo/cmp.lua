vim.o.completeopt = "menu,menuone,noselect"

require("cmp").setup({
  snippet = {
    expand = function(_)
    end,
  },
  mapping = {},
  enabled = function()
    return not vim.tbl_contains({"thetto-input", "reacher", "searcho"}, vim.bo.filetype)
  end,
  sources = {
    {name = "neosnippet"},
    {name = "nvim_lsp"},
    {name = "nvim_lua"},
    {name = "buffer"},
    {name = "path"},
  },
})
