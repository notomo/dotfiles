local M = {}

function M.text_object_mapping()
  local function select_ob(query)
    return function()
      require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
    end
  end

  vim.keymap.set({ "o", "x" }, "ic", select_ob("@call.inner"), { buf = 0, silent = true })
  vim.keymap.set({ "o", "x" }, "ac", select_ob("@call.outer"), { buf = 0, silent = true })

  vim.keymap.set({ "o", "x" }, "if", select_ob("@function.inner"), { buf = 0, silent = true })
  vim.keymap.set({ "o", "x" }, "af", select_ob("@function.outer"), { buf = 0, silent = true })

  if vim.bo.filetype == "typescriptreact" then
    vim.keymap.set({ "o", "x" }, "ir", select_ob("@attribute.inner"), { buf = 0, silent = true })
    vim.keymap.set({ "o", "x" }, "ar", select_ob("@attribute.outer"), { buf = 0, silent = true })
  else
    vim.keymap.set({ "o", "x" }, "ir", select_ob("@parameter.inner"), { buf = 0, silent = true })
    vim.keymap.set({ "o", "x" }, "ar", select_ob("@parameter.outer"), { buf = 0, silent = true })
  end

  vim.keymap.set({ "o", "x" }, "iv", select_ob("@block.inner"), { buf = 0, silent = true })
  vim.keymap.set({ "o", "x" }, "av", select_ob("@block.outer"), { buf = 0, silent = true })

  vim.keymap.set({ "o", "x" }, "is", select_ob("@statement.inner"), { buf = 0, silent = true })
  vim.keymap.set({ "o", "x" }, "as", select_ob("@statement.outer"), { buf = 0, silent = true })

  vim.keymap.set("n", "so", function()
    local tmp = vim.fn.getreg("9")

    local cursor = vim.api.nvim_win_get_cursor(0)
    require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects")
    vim.cmd.normal({ args = { [[vh]] }, bang = true })

    require("nvim-treesitter-textobjects.select").select_textobject("@call.inner", "textobjects")
    vim.cmd.normal({ args = { [["9y]] }, bang = true })

    vim.api.nvim_win_set_cursor(0, cursor)
    require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects")
    vim.cmd.normal({ args = { [["9p]] }, bang = true })

    local after_moved = vim.api.nvim_win_get_cursor(0)
    if cursor[1] == after_moved[1] and cursor[2] < after_moved[2] then
      vim.api.nvim_win_set_cursor(0, cursor)
    end

    vim.fn.setreg("9", tmp)
  end)
end

function M.mapping()
  require("notomo.plugin.nvim-treesitter").text_object_mapping()
end

return M
