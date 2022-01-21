local M = {}

function M.setup()
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
      select = {
        enable = true,
      },
    },
  })
end

function M.text_object_mapping()
  local set = function(lhs, query)
    vim.keymap.set("o", lhs, function()
      vim.cmd([[TSTextobjectSelect ]] .. query)
    end, { buffer = true })
    vim.keymap.set("x", lhs, function()
      -- HACK
      return ([[:lua require("nvim-treesitter.textobjects.select").select_textobject("%s", "x")<CR>]]):format(query)
    end, { silent = true, buffer = true, expr = true })
  end

  set("ic", "@call.inner")
  set("ac", "@call.outer")

  set("if", "@function.inner")
  set("af", "@function.outer")

  set("ir", "@parameter.inner")
  set("ar", "@parameter.outer")

  set("iv", "@block.inner")
  set("av", "@block.outer")

  set("is", "@statement.outer")
  set("as", "@statement.outer")
end

return M
