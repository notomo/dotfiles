local M = {}

function M.setup()
  vim.keymap.set(
    "n",
    "[git]s",
    [[<Cmd>lua require("notomo.plugin.gina.util").toggle_buffer('status', 'gina-status')<CR>]],
    { silent = true }
  )
  vim.keymap.set("n", "[git]D", [[<Cmd>Gina diff<CR>]])
  vim.keymap.set("n", "[git]L", [[<Cmd>Gina log master...HEAD<CR>]])
  vim.keymap.set("n", "[git]ll", [[<Cmd>Gina log<CR>]])

  vim.keymap.set("n", "[git]P", function()
    return ":<C-u>Gina! push "
      .. require("notomo.plugin.gina.util").remote()
      .. " "
      .. vim.fn["gina#component#repo#branch"]()
  end, { expr = true })
  vim.keymap.set("n", "[git]H", function()
    return ":<C-u>Gina! pull "
      .. require("notomo.plugin.gina.util").remote()
      .. " "
      .. vim.fn["gina#component#repo#branch"]()
  end, { expr = true })
  vim.keymap.set("n", "[git]F", function()
    return ":<C-u>Gina! fetch " .. require("notomo.plugin.gina.util").remote() .. " --prune"
  end, { expr = true })

  vim.keymap.set("n", "[git]ma", [[:<C-u>Gina! merge --abort]])
  vim.keymap.set("n", "[git]ca", [[:<C-u>Gina! cherry-pick --abort]])
  vim.keymap.set("n", "[git]ra", [[:<C-u>Gina! rebase --abort]])

  vim.keymap.set("n", "[git]A", function()
    return ":<C-u>Gina! apply " .. vim.fn.fnamemodify(vim.fn.bufname("%"), ":p")
  end, { expr = true })

  vim.keymap.set("n", "[git]dl", [[<Cmd>Gina log --diff-filter=D --summary<CR> " deleted file log]])
  vim.keymap.set("n", "[git]G", [[:<C-u>Gina log -S""<Left>]])

  vim.keymap.set("n", "[yank]U", [[<Cmd>Gina browse : --yank<CR>:echomsg 'yank ' . @+<CR>]])
  vim.keymap.set("x", "[yank]U", [[:Gina browse : --yank --exact<CR>:echomsg 'yank ' . @+<CR>]])

  vim.keymap.set("n", "[exec]gu", [[<Cmd>Gina browse :<CR>]])
  vim.keymap.set("n", "[git]B", function()
    return ":<C-u>Gina blame :" .. require("notomo.plugin.gina.util").relpath() .. "<CR>"
  end, { expr = true })
  vim.keymap.set("n", "[git]fl", function()
    return ":<C-u>Gina log :" .. require("notomo.plugin.gina.util").relpath() .. "<CR>"
  end, { expr = true })
  vim.keymap.set("n", "[git]dd", function()
    return ":<C-u>Gina compare :" .. require("notomo.plugin.gina.util").relpath() .. "<CR>"
  end, { expr = true })
  vim.keymap.set("n", "[git]df", function()
    return ":<C-u>Gina diff :" .. require("notomo.plugin.gina.util").relpath() .. "<CR>"
  end, { expr = true })
end

return M
