vim.g.mapleader = ","
vim.g.maplocalleader = "<Leader>l"

local set_prefix = require("notomo.mapping.util").set_prefix
set_prefix({ "n", "x" }, "exec", "<Space>x")
set_prefix({ "n" }, "keyword", "<Space>k")
set_prefix({ "n" }, "file", "<Space>f")
set_prefix({ "n", "x" }, "operator", "<Space><Leader>")
set_prefix({ "n", "x" }, "finder", "<Space>d")
set_prefix({ "n" }, "qf", "<Space>q")
set_prefix({ "n" }, "winmv", "m")
set_prefix({ "n" }, "win", "<Space>w")
set_prefix({ "n", "x" }, "tab", "t")
set_prefix({ "n" }, "term", "<Space>t")
set_prefix({ "n", "x" }, "arith", "<Space>a")
set_prefix({ "n", "x" }, "yank", "<Space>y")
set_prefix({ "n" }, "newline", "o")

vim.keymap.set("n", "[exec]r", [[<Cmd>source $DOTFILES/tool/vscode/neovim.vim<CR><Cmd>echomsg 'reloaded'<CR>]])
vim.keymap.set("n", "[exec]R", [[<Cmd>call VSCodeNotify("workbench.action.reloadWindow")<CR>]])
vim.keymap.set("n", "[exec]f", [[<Cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>]])
vim.keymap.set("n", "[exec]m", [[<Cmd>call VSCodeNotify("markdown.showPreviewToSide")<CR>]])
vim.keymap.set("n", "[exec]n", [[<Cmd>nohlsearch<CR>]])
vim.keymap.set("n", "[exec]ljo", [[<Cmd>call VSCodeNotify("liveshare.join")<CR>]])
vim.keymap.set("n", "[exec]ls", [[<Cmd>call VSCodeNotify("liveshare.start")<CR>]])
vim.keymap.set("n", "[exec]o", [[<Cmd>call VSCodeNotify("workbench.explorer.fileView.focus")<CR>]])
vim.keymap.set("n", "[exec]N", [[<Cmd>lua require("notomo.edit").note()<CR>]])

vim.keymap.set("n", "k", [[gk]])
vim.keymap.set("n", "j", [[gj]])
vim.keymap.set("x", "k", [[gk]])
vim.keymap.set("x", "j", [[gj]])

vim.keymap.set("n", "ge", [[$]])
vim.keymap.set("x", "ge", [[$]])
vim.keymap.set("o", "ge", [[$]])
vim.keymap.set("n", "ga", [[^]])
vim.keymap.set("x", "ga", [[^]])
vim.keymap.set("o", "ga", [[^]])
vim.keymap.set("n", "gh", [[0]])
vim.keymap.set("x", "gh", [[0]])
vim.keymap.set("o", "gh", [[0]])
vim.keymap.set("n", "gz", [[G]])
vim.keymap.set("x", "gz", [[G]])
vim.keymap.set("o", "gz", [[G]])

vim.keymap.set("o", "gp", [[])]])
vim.keymap.set("x", "gp", [[])h]])
vim.keymap.set("o", "gd", [[]}]])
vim.keymap.set("x", "gd", [[]}h]])
vim.keymap.set("o", "gl", [=[t]]=])
vim.keymap.set("o", "gs", [[t"]])
vim.keymap.set("o", "gb", [[t`]])
vim.keymap.set("o", "gq", [[t']])
vim.keymap.set("o", "gx", [[t*]])
vim.keymap.set("o", "gt", [[t>]])
vim.keymap.set("o", "g;", [[t;]])
vim.keymap.set("o", "g,", [[t,]])
vim.keymap.set("o", "g.", [[t.]])
vim.keymap.set("o", "gc", [[t:]])
vim.keymap.set("o", "gP", [[t(]])

vim.keymap.set("n", "go", [[<Cmd>call VSCodeNotify("workbench.action.navigateBack")<CR>]])
vim.keymap.set("n", "gi", [[<Cmd>call VSCodeNotify("workbench.action.navigateForward")<CR>]])

vim.keymap.set("n", "<Space>h", [[<C-v>]])
vim.keymap.set("n", "<Space>l", [[<S-v>]])
vim.keymap.set("n", "<Space>v", [[gv]])
vim.keymap.set("x", "<Space>h", [[<C-v>]])
vim.keymap.set("x", "<Space>l", [[<S-v>]])
vim.keymap.set("x", "<Space>v", [[v]])
vim.keymap.set("x", "v", [[<ESC>]])

vim.keymap.set("x", "<S-j>", [[}]])
vim.keymap.set("x", "<S-k>", [[{]])
-- for matchit
vim.keymap.set("x", "<S-l>", [[%]])
vim.keymap.set("n", "<S-l>", [[<Cmd>keepjumps normal %<CR>]])

vim.keymap.set("n", "<S-j>", [[<Cmd>keepjumps normal! }<CR>]])
vim.keymap.set("n", "<S-k>", [[<Cmd>keepjumps normal! {<CR>]])

vim.keymap.set("n", "[newline]o", function()
  for _ in ipairs(vim.fn.range(vim.v.count1)) do
    vim.fn.append(vim.fn.line("."), "")
  end
end, { silent = true })
vim.keymap.set("n", "[newline]j", function()
  for _ in ipairs(vim.fn.range(vim.v.count1)) do
    vim.fn.append(vim.fn.line("."), "")
    vim.cmd.normal({ args = { "j" }, bang = true })
  end
end, { silent = true })

vim.keymap.set("n", "[arith]j", function()
  return require("notomo.edit").inc_or_dec(false)
end, { expr = true })
vim.keymap.set("n", "[arith]k", function()
  return require("notomo.edit").inc_or_dec(true)
end, { expr = true })
vim.keymap.set("x", "[arith]j", [[<C-x>gv]])
vim.keymap.set("x", "[arith]k", [[<C-a>gv]])
vim.keymap.set("x", "[arith]d", [[g<C-x>gv]])
vim.keymap.set("x", "[arith]u", [[g<C-a>gv]])

vim.keymap.set("n", "[file]w", [[<Cmd>call VSCodeNotify("workbench.action.files.save")<CR>]])

vim.keymap.set("n", "x", [["_x]])
vim.keymap.set("x", "x", [["_x]])

vim.keymap.set("n", "[operator]x", [["_d]])
vim.keymap.set("x", "[operator]x", [["_d]])

vim.keymap.set("n", ";", [[:]])
vim.keymap.set("n", ":", [[;]])
vim.keymap.set("x", ";", [[:]])
vim.keymap.set("x", ":", [[;]])

local set_ia_xo = function(lhs, rhs)
  local inner_lhs = "i" .. lhs
  local inner_rhs = "i" .. rhs
  local around_lhs = "a" .. lhs
  local around_rhs = "a" .. rhs
  vim.keymap.set({ "x", "o" }, inner_lhs, inner_rhs)
  vim.keymap.set({ "x", "o" }, around_lhs, around_rhs)
end
set_ia_xo("o", "p")
set_ia_xo(";", "w")
set_ia_xo("<Space>", "W")
set_ia_xo("t", ">")
set_ia_xo("T", "t")
set_ia_xo("p", ")")
set_ia_xo("l", "]")
set_ia_xo("w", '"')
set_ia_xo("q", "'")
set_ia_xo("d", "}")
set_ia_xo("b", "`")

vim.keymap.set("n", "[winmv]a", [[<Cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>]])
vim.keymap.set("n", "[winmv]x", [[<Cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>]])
vim.keymap.set("n", "[winmv]w", [[<Cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>]])
vim.keymap.set("n", "[winmv]l", [[<Cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>]])

vim.keymap.set("n", "[win]v", [[<Cmd>call VSCodeNotify("workbench.action.splitEditorLeft")<CR>]])
vim.keymap.set("n", "[win]o", [[<Cmd>Only<CR><Cmd>call VSCodeNotify("workbench.action.closeSidebar")<CR>]])

vim.keymap.set("n", "[term]o", [[<Cmd>call VSCodeCall("terminal.focus")<CR>]])
vim.keymap.set(
  "n",
  "[term]v",
  [[<Cmd>call VSCodeCall("terminal.focus")<CR><Cmd>call VSCodeNotify("workbench.action.positionPanelLeft")<CR><Cmd>call VSCodeCall("terminal.focus")<CR>]]
)
vim.keymap.set(
  "n",
  "[term]V",
  [[<Cmd>call VSCodeCall("terminal.focus")<CR><Cmd>call VSCodeNotify("workbench.action.positionPanelLeft")<CR><Cmd>call VSCodeCall("terminal.focus")<CR><Cmd>call VSCodeNotify("workbench.action.terminal.sendSequence", {'text': "nvim\n"})<CR>]]
)

vim.keymap.set("n", "T", [[<Cmd>call VSCodeNotify("workbench.action.toggleMaximizedPanel")<CR>]])

vim.keymap.set("n", "[tab]q", [[<Cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>]])
vim.keymap.set("n", "[tab]o", [[<Cmd>call VSCodeNotify("workbench.action.closeOtherEditors")<CR>]])
vim.keymap.set("n", "[tab]l", [[<Cmd>call VSCodeNotify("workbench.action.nextEditorInGroup")<CR>]])
vim.keymap.set("n", "[tab]a", [[<Cmd>call VSCodeNotify("workbench.action.previousEditorInGroup")<CR>]])
vim.keymap.set("n", "[tab]t", [[<Cmd>call VSCodeNotify("workbench.action.files.newUntitledFile")<CR>]])

vim.keymap.set("n", "[keyword]o", [[<Cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>]])
vim.keymap.set("n", "[keyword]k", [[<Cmd>call VSCodeNotify("editor.action.showHover")<CR>]])

vim.keymap.set("n", "[finder];", [[<Cmd>call VSCodeNotify("workbench.action.showCommands")<CR>]])
vim.keymap.set("n", "[finder]k", [[<Cmd>call VSCodeNotify("workbench.action.openGlobalKeybindings")<CR>]])
vim.keymap.set("n", "[finder]G", [[<Cmd>call VSCodeNotify("workbench.action.findInFiles")<CR>]])
vim.keymap.set("n", "<Space>ur", [[<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>]])

vim.keymap.set("n", "[qf]n", [[<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>]])
vim.keymap.set("n", "[qf]p", [[<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>]])
vim.keymap.set("n", "[qf]N", [[<Cmd>call VSCodeNotify("editor.action.marker.nextInFiles")<CR>]])
vim.keymap.set("n", "[qf]P", [[<Cmd>call VSCodeNotify("editor.action.marker.prevInFiles")<CR>]])
vim.keymap.set("n", "[qf]o", [[<Cmd>call VSCodeNotify("workbench.action.problems.focus")<CR>]])

vim.keymap.set("n", "<Space>c", [[<Cmd>VSCodeCommentary<CR>]])
vim.keymap.set("x", "<Space>c", [[:VSCodeCommentary<CR>]])

vim.keymap.set(
  "n",
  "[yank]d",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.strftime('%Y-%m-%d'))<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[yank]w",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.expand('%:p:h:t'))<CR>]],
  { silent = true }
)

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set("n", "sj", [[*N]])
vim.keymap.set("n", "sk", [[#N]])

-- TODO
-- escape
-- substitute

local pack_dir = vim.fn.expand("~/.vim/packages")
vim.opt.packpath:prepend(pack_dir)

vim.cmd.packadd([[vim-textobj-user]])
vim.cmd.packadd([[vim-operator-user]])
vim.cmd.packadd([[misclib.nvim]])

vim.cmd.packadd([[CamelCaseMotion]])
vim.keymap.set({ "n", "x", "o" }, "<Leader>w", "<Plug>CamelCaseMotion_w")
vim.keymap.set({ "n", "x", "o" }, "<Leader>b", "<Plug>CamelCaseMotion_b")
vim.keymap.set({ "n", "x", "o" }, "<Leader>e", "<Plug>CamelCaseMotion_e")

vim.cmd.packadd([[vim-operator-replace]])
vim.keymap.set("n", "r", [[<Plug>(operator-replace)]])
vim.keymap.set("x", "r", [[<Plug>(operator-replace)]])
vim.keymap.set("o", "r", [[<Plug>(operator-replace)]])

vim.cmd.packadd([[vim-textobj-line]])
vim.keymap.set({ "x", "o" }, "ag", [[<Plug>(textobj-line-a)]])
vim.keymap.set({ "x", "o" }, "ig", [[<Plug>(textobj-line-i)]])

vim.cmd.packadd([[vim-smartword]])
vim.keymap.set({ "n", "x", "o" }, "w", [[<Plug>(smartword-w)]])
vim.keymap.set({ "n", "x", "o" }, "b", [[<Plug>(smartword-b)]])
vim.keymap.set({ "n", "x", "o" }, "e", [[<Plug>(smartword-e)]])

vim.cmd.packadd([[vim-textobj-entire]])
vim.keymap.set({ "o", "x" }, "ae", [[<Plug>(textobj-entire-a)]])
vim.keymap.set({ "o", "x" }, "ie", [[<Plug>(textobj-entire-i)]])
