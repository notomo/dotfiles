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
    {name = "path"},
    {
      name = "buffer",
      opts = {
        keyword_pattern = [[\k\+]],
        get_bufnrs = function()
          local bufnrs = {}
          for _, window_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            bufnrs[vim.api.nvim_win_get_buf(window_id)] = true
          end
          return vim.tbl_keys(bufnrs)
        end,
      },
    },
  },
})
