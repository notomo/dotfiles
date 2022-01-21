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
  vim.keymap.set("o", "ic", function()
    vim.cmd([[TSTextobjectSelect @call.inner]])
  end, { buffer = true })
  vim.keymap.set("o", "ac", function()
    vim.cmd([[TSTextobjectSelect @call.outer]])
  end, { buffer = true })

  vim.keymap.set("o", "if", function()
    vim.cmd([[TSTextobjectSelect @function.inner]])
  end, { buffer = true })
  vim.keymap.set("o", "af", function()
    vim.cmd([[TSTextobjectSelect @function.outer]])
  end, { buffer = true })

  vim.keymap.set("o", "ir", function()
    vim.cmd([[TSTextobjectSelect @parameter.inner]])
  end, { buffer = true })
  vim.keymap.set("o", "ar", function()
    vim.cmd([[TSTextobjectSelect @parameter.outer]])
  end, { buffer = true })

  vim.keymap.set("o", "iv", function()
    vim.cmd([[TSTextobjectSelect @block.inner]])
  end, { buffer = true })
  vim.keymap.set("o", "av", function()
    vim.cmd([[TSTextobjectSelect @block.outer]])
  end, { buffer = true })
end

return M
