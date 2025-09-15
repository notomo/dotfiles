local M = {}

function M.text_object_mapping()
  local treesitter_text_object_select = function(query)
    return function()
      require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
    end
  end

  vim.keymap.set("o", "ic", treesitter_text_object_select("@call.inner"), { buffer = true })
  vim.keymap.set("x", "ic", treesitter_text_object_select("@call.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "ac", treesitter_text_object_select("@call.outer"), { buffer = true })
  vim.keymap.set("x", "ac", treesitter_text_object_select("@call.outer"), { buffer = true, silent = true })

  vim.keymap.set("o", "if", treesitter_text_object_select("@function.inner"), { buffer = true })
  vim.keymap.set("x", "if", treesitter_text_object_select("@function.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "af", treesitter_text_object_select("@function.outer"), { buffer = true })
  vim.keymap.set("x", "af", treesitter_text_object_select("@function.outer"), { buffer = true, silent = true })

  vim.keymap.set("o", "ir", treesitter_text_object_select("@parameter.inner"), { buffer = true })
  vim.keymap.set("x", "ir", treesitter_text_object_select("@parameter.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "ar", treesitter_text_object_select("@parameter.outer"), { buffer = true })
  vim.keymap.set("x", "ar", treesitter_text_object_select("@parameter.outer"), { buffer = true, silent = true })

  vim.keymap.set("o", "iv", treesitter_text_object_select("@block.inner"), { buffer = true })
  vim.keymap.set("x", "iv", treesitter_text_object_select("@block.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "av", treesitter_text_object_select("@block.outer"), { buffer = true })
  vim.keymap.set("x", "av", treesitter_text_object_select("@block.outer"), { buffer = true, silent = true })

  vim.keymap.set("o", "is", treesitter_text_object_select("@statement.inner"), { buffer = true })
  vim.keymap.set("x", "is", treesitter_text_object_select("@statement.inner"), { buffer = true, silent = true })
  vim.keymap.set("o", "as", treesitter_text_object_select("@statement.outer"), { buffer = true })
  vim.keymap.set("x", "as", treesitter_text_object_select("@statement.outer"), { buffer = true, silent = true })

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
  vim.keymap.set(
    { "n", "x" },
    "sgj",
    [[<Cmd>lua require("notomo.plugin.nvim-treesitter").next_no_indent_function()<CR>]],
    { buffer = true }
  )
  vim.keymap.set(
    { "n", "x" },
    "sgk",
    [[<Cmd>lua require("notomo.plugin.nvim-treesitter").prev_no_indent_function()<CR>]],
    { buffer = true }
  )

  require("notomo.plugin.nvim-treesitter").text_object_mapping()
end

function M.next_no_indent_function()
  M._move(function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
  end)
end

function M.prev_no_indent_function()
  M._move(function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
  end)
end

function M._move(move_fn)
  local origin_pos = vim.api.nvim_win_get_cursor(0)
  local view = vim.fn.winsaveview()

  local next_pos = origin_pos
  while true do
    local prev_pos = vim.api.nvim_win_get_cursor(0)
    move_fn()
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
