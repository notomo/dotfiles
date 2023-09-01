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
      vim.cmd.TSTextobjectSelect(query)
    end, { buffer = true })
    vim.keymap.set("x", lhs, function()
      -- HACK
      return ([[:lua require("nvim-treesitter.textobjects.select").select_textobject("%s", nil, "x")<CR>]]):format(
        query
      )
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
