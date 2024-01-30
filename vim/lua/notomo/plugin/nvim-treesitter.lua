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
    autotag = {
      enable = true,
    },
  })
end

function M.text_object_mapping()
  local treesitter_text_object_operator = function(query)
    return function()
      vim.cmd.TSTextobjectSelect(query)
    end
  end

  local treesitter_text_object_select = function(query)
    return function()
      require("nvim-treesitter.textobjects.select").select_textobject(query, nil, "x")
    end
  end

  vim.keymap.set("o", "ic", treesitter_text_object_operator("@call.inner"), { buffer = true })
  vim.keymap.set("x", "ic", treesitter_text_object_select("@call.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "ac", treesitter_text_object_operator("@call.outer"), { buffer = true })
  vim.keymap.set("x", "ac", treesitter_text_object_select("@call.outer"), { buffer = true, silent = true })

  vim.keymap.set("o", "if", treesitter_text_object_operator("@function.inner"), { buffer = true })
  vim.keymap.set("x", "if", treesitter_text_object_select("@function.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "af", treesitter_text_object_operator("@function.outer"), { buffer = true })
  vim.keymap.set("x", "af", treesitter_text_object_select("@function.outer"), { buffer = true, silent = true })

  vim.keymap.set("o", "ir", treesitter_text_object_operator("@parameter.inner"), { buffer = true })
  vim.keymap.set("x", "ir", treesitter_text_object_select("@parameter.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "ar", treesitter_text_object_operator("@parameter.outer"), { buffer = true })
  vim.keymap.set("x", "ar", treesitter_text_object_select("@parameter.outer"), { buffer = true, silent = true })

  vim.keymap.set("o", "iv", treesitter_text_object_operator("@block.inner"), { buffer = true })
  vim.keymap.set("x", "iv", treesitter_text_object_select("@block.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "av", treesitter_text_object_operator("@block.outer"), { buffer = true })
  vim.keymap.set("x", "av", treesitter_text_object_select("@block.outer"), { buffer = true, silent = true })

  vim.keymap.set("o", "is", treesitter_text_object_operator("@statement.inner"), { buffer = true })
  vim.keymap.set("x", "is", treesitter_text_object_select("@statement.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "as", treesitter_text_object_operator("@statement.outer"), { buffer = true })
  vim.keymap.set("x", "as", treesitter_text_object_select("@statement.outer"), { buffer = true, silent = true })

  vim.keymap.set("n", "so", function()
    local tmp = vim.fn.getreg("9")

    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd.TSTextobjectSelect("@call.outer")
    vim.cmd.normal({ args = { [[vh]] }, bang = true })

    vim.cmd.TSTextobjectSelect("@call.inner")
    vim.cmd.normal({ args = { [["9y]] }, bang = true })

    vim.api.nvim_win_set_cursor(0, cursor)
    vim.cmd.TSTextobjectSelect("@call.outer")
    vim.cmd.normal({ args = { [["9p]] }, bang = true })

    local after_moved = vim.api.nvim_win_get_cursor(0)
    if cursor[1] == after_moved[1] and cursor[2] < after_moved[2] then
      vim.api.nvim_win_set_cursor(0, cursor)
    end

    vim.fn.setreg("9", tmp)
  end)
end

function M.mapping()
  vim.keymap.set(
    "n",
    "sgj",
    [[<Cmd>lua require("notomo.plugin.nvim-treesitter").next_no_indent_function()<CR>]],
    { buffer = true }
  )
  vim.keymap.set(
    "n",
    "sgk",
    [[<Cmd>lua require("notomo.plugin.nvim-treesitter").prev_no_indent_function()<CR>]],
    { buffer = true }
  )

  vim.keymap.set("n", "<CR>", function()
    vim.cmd.normal({ args = { "m'" }, bang = true })
    require("nvim-treesitter.incremental_selection").init_selection()
    require("nvim-treesitter.incremental_selection").node_incremental()
  end, { buffer = true })
  vim.keymap.set("x", "<CR>", function()
    require("nvim-treesitter.incremental_selection").node_incremental()
  end, { buffer = true })
  vim.keymap.set("x", "g<CR>", function()
    require("nvim-treesitter.incremental_selection").node_decremental()
  end, { buffer = true })

  vim.keymap.set("x", "D", function()
    require("notomo.lib.treesitter").unwrap_selected_node()
  end, { silent = true })

  require("notomo.plugin.nvim-treesitter").text_object_mapping()
end

function M.next_no_indent_function()
  M._move("TSTextobjectGotoNextStart", "@function.outer")
end

function M.prev_no_indent_function()
  M._move("TSTextobjectGotoPreviousStart", "@function.outer")
end

function M._move(cmd_name, query_string)
  local origin_pos = vim.api.nvim_win_get_cursor(0)
  local view = vim.fn.winsaveview()

  local next_pos = origin_pos
  while true do
    local prev_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd[cmd_name](query_string)
    local pos = vim.api.nvim_win_get_cursor(0)
    if prev_pos[1] == pos[1] then
      break
    end
    if pos[2] == 0 then
      next_pos = pos
      break
    end
  end

  vim.fn.winrestview(view)
  if next_pos == origin_pos then
    return
  end
  vim.cmd.normal({ args = { "m" }, bang = true })
  vim.api.nvim_win_set_cursor(0, next_pos)
end

return M
