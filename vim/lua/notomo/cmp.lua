local M = {}

local cmp = require("cmp")

function M.complete()
  if vim.fn["neosnippet#expandable"]() ~= 0 then
    vim.schedule(function()
      cmp.close()
    end)
    return vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Plug>(neosnippet_expand)", true, true, true),
      "m",
      true
    )
  end

  local selected = cmp.get_selected_entry()
  if selected then
    vim.schedule(function()
      cmp.close()
    end)
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-y>", true, true, true), "n", true)
  end

  -- NOTE: select by <C-n> and then close and expand
  vim.schedule(function()
    cmp.close()
    if vim.fn["neosnippet#expandable"]() ~= 0 then
      return vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Plug>(neosnippet_expand)", true, true, true),
        "m",
        true
      )
    end
  end)
  return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "m", true)
end

function M.tab()
  if vim.fn["neosnippet#jumpable"]() ~= 0 then
    vim.schedule(function()
      cmp.close()
    end)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(neosnippet_jump)", true, true, true), "m", true)
    return ""
  end
  if cmp.visible() then
    return vim.api.nvim_eval([["\<C-n>"]])
  end
  return vim.api.nvim_eval([["\<Tab>"]])
end

function M.setup()
  vim.cmd([[inoremap j<Space>o <Cmd>lua require('notomo.cmp').complete()<CR>]])
  vim.cmd([[imap <expr> <Tab> luaeval("require('notomo.cmp').tab()")]])
  vim.cmd([[smap <expr> <Tab> luaeval("require('notomo.cmp').tab()")]])
  cmp.setup({
    snippet = {
      expand = function(_) end,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    },
    enabled = function()
      return not vim.tbl_contains({ "thetto-input", "reacher", "searcho" }, vim.bo.filetype)
    end,
    preselect = cmp.PreselectMode.None,
    sources = {
      { name = "neosnippet" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
      {
        name = "buffer",
        option = {
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
