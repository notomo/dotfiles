local M = {}

function M.text_object_mapping()
  local select_ob = function(query)
    return function()
      require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
    end
  end

  vim.keymap.set({ "o", "x" }, "ic", select_ob("@call.inner"), { buffer = true, silent = true })
  vim.keymap.set({ "o", "x" }, "ac", select_ob("@call.outer"), { buffer = true, silent = true })

  vim.keymap.set({ "o", "x" }, "if", select_ob("@function.inner"), { buffer = true, silent = true })
  vim.keymap.set({ "o", "x" }, "af", select_ob("@function.outer"), { buffer = true, silent = true })

  if vim.bo.filetype == "typescriptreact" then
    vim.keymap.set({ "o", "x" }, "ir", select_ob("@attribute.inner"), { buffer = true, silent = true })
    vim.keymap.set({ "o", "x" }, "ar", select_ob("@attribute.outer"), { buffer = true, silent = true })
  else
    vim.keymap.set({ "o", "x" }, "ir", select_ob("@parameter.inner"), { buffer = true, silent = true })
    vim.keymap.set({ "o", "x" }, "ar", select_ob("@parameter.outer"), { buffer = true, silent = true })
  end

  vim.keymap.set({ "o", "x" }, "iv", select_ob("@block.inner"), { buffer = true, silent = true })
  vim.keymap.set({ "o", "x" }, "av", select_ob("@block.outer"), { buffer = true, silent = true })

  vim.keymap.set({ "o", "x" }, "is", select_ob("@statement.inner"), { buffer = true, silent = true })
  vim.keymap.set({ "o", "x" }, "as", select_ob("@statement.outer"), { buffer = true, silent = true })

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
