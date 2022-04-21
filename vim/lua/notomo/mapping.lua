local M = {}

function M.lsp()
  vim.keymap.set("n", "[keyword]o", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]v", [[<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]h", [[<Cmd>split | lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]t", function()
    require("wintablib.window").duplicate_as_right_tab()
    vim.lsp.buf.definition()
  end, { buffer = true })
  vim.keymap.set("n", "sl", function()
    vim.cmd([[nohlsearch]])
    vim.lsp.buf.document_highlight()
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = 0,
      once = true,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end, { buffer = true })
end

function M.gina()
  vim.keymap.set(
    "n",
    "[git]s",
    [[<Cmd>lua require("notomo.gina").toggle_buffer('status', 'gina-status')<CR>]],
    { silent = true }
  )
  vim.keymap.set("n", "[git]D", [[<Cmd>Gina diff<CR>]])
  vim.keymap.set(
    "n",
    "[git]b",
    [[<Cmd>lua require("notomo.gina").toggle_buffer('branch', 'gina-branch')<CR>]],
    { silent = true }
  )
  vim.keymap.set("n", "[git]L", [[<Cmd>Gina log master...HEAD<CR>]])
  vim.keymap.set("n", "[git]ll", [[<Cmd>Gina log<CR>]])
  vim.keymap.set("n", "[git]rl", [[<Cmd>Gina reflog<CR>]])
  vim.keymap.set("n", "[git]ls", [[<Cmd>Gina ls<CR>]])
  vim.keymap.set("n", "[git]T", [[<Cmd>Gina tag<CR>]])
  vim.keymap.set("n", "[git]c", [[<Cmd>Gina commit<CR>]])
  vim.keymap.set(
    "n",
    "[git]xl",
    [[<Cmd>lua require("notomo.gina").toggle_buffer('stash_for_list list', 'gina-stash-list')<CR>]]
  )
  vim.keymap.set("n", "[git]xs", [[:<C-u>Gina stash save ""<Left>]])
  vim.keymap.set("n", "[git]xc", [[<Cmd>Gina stash show<CR>]])
  vim.keymap.set("n", "[git]P", function()
    return ":<C-u>Gina! push " .. require("notomo.gina").remote() .. " " .. vim.fn["gina#component#repo#branch"]()
  end, { expr = true })
  vim.keymap.set("n", "[git]H", function()
    return ":<C-u>Gina! pull " .. require("notomo.gina").remote() .. " " .. vim.fn["gina#component#repo#branch"]()
  end, { expr = true })
  vim.keymap.set("n", "[git]M", [[:<C-u>Gina! merge<Space>]])
  vim.keymap.set("n", "[git]F", function()
    return ":<C-u>Gina! fetch " .. require("notomo.gina").remote() .. " --prune"
  end, { expr = true })
  vim.keymap.set("n", "[git]ma", [[:<C-u>Gina! merge --abort]])
  vim.keymap.set("n", "[git]ca", [[:<C-u>Gina! cherry-pick --abort]])
  vim.keymap.set("n", "[git]ra", [[:<C-u>Gina! rebase --abort]])
  vim.keymap.set("n", "[git]rc", [[:<C-u>Gina! rebase --continue]])
  vim.keymap.set("n", "[git]R", [[:<C-u>Gina! rebase<Space>]])
  vim.keymap.set("n", "[git]A", function()
    return ":<C-u>Gina! apply " .. vim.fn.fnamemodify(vim.fn.bufname("%"), ":p")
  end, { expr = true })
  vim.keymap.set("n", "[git]dl", [[<Cmd>Gina log --diff-filter=D --summary<CR> " deleted file log]])
  vim.keymap.set("n", "[git]G", [[:<C-u>Gina log -S""<Left>]])
  vim.keymap.set("n", "[yank]U", [[<Cmd>Gina browse : --yank<CR>:echomsg 'yank ' . @+<CR>]])
  vim.keymap.set("x", "[yank]U", [[:Gina browse : --yank --exact<CR>:echomsg 'yank ' . @+<CR>]])
  vim.keymap.set("n", "[exec]gu", [[<Cmd>Gina browse :<CR>]])
  vim.keymap.set("n", "[git]B", function()
    return ":<C-u>Gina blame :" .. require("notomo.gina").relpath() .. "<CR>"
  end, { expr = true })
  vim.keymap.set("n", "[git]fl", function()
    return ":<C-u>Gina log :" .. require("notomo.gina").relpath() .. "<CR>"
  end, { expr = true })
  vim.keymap.set("n", "[git]dd", function()
    return ":<C-u>Gina compare :" .. require("notomo.gina").relpath() .. "<CR>"
  end, { expr = true })
  vim.keymap.set("n", "[git]df", function()
    return ":<C-u>Gina diff :" .. require("notomo.gina").relpath() .. "<CR>"
  end, { expr = true })
end

function M.npm()
  vim.keymap.set(
    "n",
    "[exec]bl",
    [[<Cmd>lua require("cmdhndlr").build({name = 'javascript/npm'})<CR>]],
    { buffer = true }
  )
  vim.keymap.set(
    "n",
    "[test]t",
    [[<Cmd>lua require("cmdhndlr").test({name = 'javascript/npm', layout = {type = "tab"}})<CR>]],
    { buffer = true }
  )
  vim.keymap.set(
    "n",
    "[exec],",
    [[<Cmd>lua require("thetto").start("cmd/npm/script", {opts = {sorters = {"alphabet"}, target = "upward", target_patterns = {"package.json"}, insert = false}})<CR>]],
    { buffer = true }
  )
end

function M.set_prefix(modes, name, key)
  local name_key = ("[%s]"):format(name)
  vim.keymap.set(modes, name_key, "<Nop>")
  vim.keymap.set(modes, key, name_key, { remap = true })
end

return M
