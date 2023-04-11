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

  if not cmp.visible() then
    vim.schedule(function()
      cmp.complete({
        config = { sources = { { name = "nvim_lsp" } } },
      })
    end)
    return ""
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
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "Keyword" })
  vim.keymap.set("i", "j<Space>o", [[<Cmd>lua require("notomo.plugin.cmp").complete()<CR>]])
  vim.keymap.set({ "i", "s" }, "<Tab>", function()
    return require("notomo.plugin.cmp").tab()
  end, { expr = true, remap = true })
  vim.keymap.set("i", "<C-x><C-o>", [[<Cmd>lua require("cmp").complete()<CR>]])

  local documentation = cmp.config.window.bordered()
  documentation.zindex = 999
  documentation.border = "solid"
  documentation.winhighlight = "Normal:NormalFloat,NormalFloat:NormalFloat,FloatBorder:NormalFloat"

  cmp.setup({
    snippet = {
      expand = function(_) end,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    },
    enabled = function()
      return not vim.tbl_contains({ "thetto-input", "reacher", "searcho" }, vim.bo.filetype)
    end,
    preselect = cmp.PreselectMode.None,
    window = {
      documentation = documentation,
    },
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
