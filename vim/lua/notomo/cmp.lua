local M = {}

local cmp = require("cmp")

function M.complete()
  if vim.fn["neosnippet#expandable"]() ~= 0 then
    cmp.close()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(neosnippet_expand)", true, true, true), "m", true)
    return ""
  end

  -- TODO: close if selected

  -- NOTE: select by <C-n> and then close and expand
  vim.schedule(function()
    cmp.close()
    if vim.fn["neosnippet#expandable"]() ~= 0 then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(neosnippet_expand)", true, true, true), "m", true)
    end
  end)
  return vim.api.nvim_eval([["\<C-n>"]])
end

function M.tab()
  if vim.fn["neosnippet#jumpable"]() ~= 0 then
    cmp.close()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(neosnippet_jump)", true, true, true), "m", true)
    return ""
  end
  if cmp.visible() then
    return vim.api.nvim_eval([["\<C-n>"]])
  end
  return vim.api.nvim_eval([["\<Tab>"]])
end

function M.setup()
  vim.cmd([[imap <expr> j<Space>o luaeval("require('notomo.cmp').complete()")]])
  vim.cmd([[imap <expr> <Tab> luaeval("require('notomo.cmp').tab()")]])
  vim.cmd([[smap <expr> <Tab> luaeval("require('notomo.cmp').tab()")]])
  vim.o.completeopt = "menu,menuone,noselect"
  cmp.setup({
    snippet = {
      expand = function(_)
      end,
    },
    mapping = {["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert})},
    enabled = function()
      if vim.startswith(vim.api.nvim_buf_get_name(0), "kivi://") then
        return false
      end
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
end

return M
