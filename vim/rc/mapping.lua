vim.g.mapleader = ","
vim.g.maplocalleader = "<Leader>l"

local silent = { silent = true }
local remap = { remap = true }
local silent_remap = { silent = true, remap = true }
local expr = { expr = true }

local set_prefix = require("notomo.mapping").set_prefix

set_prefix({ "n", "x" }, "exec", "<Space>x")
set_prefix({ "n" }, "keyword", "<Space>k")
set_prefix({ "n", "x" }, "diff", "<Leader>d")
set_prefix({ "n", "x" }, "edit", "<Space>e")
set_prefix({ "n" }, "file", "<Space>f")
set_prefix({ "n", "x" }, "operator", "<Space><Leader>")
set_prefix({ "n", "x" }, "git", "<Leader>g")
set_prefix({ "n" }, "test", "<Leader>t")
set_prefix({ "n", "x" }, "substitute", "<Space>s")
set_prefix({ "n", "x" }, "finder", "<Space>d")
set_prefix({ "n" }, "buf", "<Space>b")
set_prefix({ "n", "x" }, "indent", "<Space>i")
set_prefix({ "n" }, "qf", "<Space>q")
set_prefix({ "n" }, "winmv", "m")
set_prefix({ "n" }, "win", "<Space>w")
set_prefix({ "n", "x" }, "tab", "t")
set_prefix({ "n" }, "term", "<Space>t")
set_prefix({ "n", "x" }, "arith", "<Space>a")
set_prefix({ "n", "x" }, "yank", "<Space>y")
set_prefix({ "n" }, "newline", "o")

vim.keymap.set({ "n", "x" }, "x", [["_x]])
vim.keymap.set({ "n", "x" }, "[operator]x", [["_d]])
vim.keymap.set({ "n", "x" }, "c", [["_c]])

vim.keymap.set({ "n", "x" }, "<Space>.", [[@:]])
vim.keymap.set("n", "<Leader>r", [[<C-r>]])
vim.keymap.set("n", "<Leader>x", [[<Cmd>lua require("notomo.edit").exchange()<CR>]], silent)
vim.keymap.set({ "n", "x" }, "[edit]r", [[r]])
vim.keymap.set({ "n", "x" }, "[edit]h", [[gU]])
vim.keymap.set({ "n", "x" }, "[edit]l", [[gu]])
vim.keymap.set("n", "[edit]t", [[viwo<ESC>g~l]])
vim.keymap.set("n", "[edit]m", [[i<C-@>]])
vim.keymap.set("n", "[edit]j", [[<Cmd>join<CR>]])
vim.keymap.set("x", "[edit]j", [[:join<CR>]])
vim.keymap.set("n", "[edit]d", [[*N"_cgn]])
vim.keymap.set("n", "[edit]a", [[*``cgn<C-r>"]])
vim.keymap.set("n", "[edit]p", [[[p]])
vim.keymap.set("n", "[edit]P", [[[P]])
vim.keymap.set("n", "い", [[i]])
vim.keymap.set("n", "あ", [[a]])
vim.keymap.set("n", "[file]w", [[<Cmd>write<CR>]])
vim.keymap.set("n", "[file]rl", [[:<C-u>edit!<CR>]])
vim.keymap.set("n", "[file]R", [[<Cmd>lua require("notomo.edit").rotate_file()<CR>]])

vim.keymap.set("n", "[buf]a", [[<C-^>]])

vim.keymap.set("n", ";", [[:]])
vim.keymap.set("n", ":", [[;]])
vim.keymap.set("x", ";", [[:]])
vim.keymap.set("x", ":", [[;]])
vim.keymap.set("n", "<Space>h", [[<C-v>]])
vim.keymap.set("n", "<Space>l", [[<S-v>]])
vim.keymap.set("n", "<Space>v", [[gv]])
vim.keymap.set("n", "<Space>p", function()
  vim.fn.setpos("'<", { 0, vim.fn.line("'["), vim.fn.col("'[") })
  vim.fn.setpos("'>", { 0, vim.fn.line("']"), vim.fn.col("']") })
  vim.cmd([[normal! gv]])
end)
vim.keymap.set("x", "<Space>h", [[<C-v>]])
vim.keymap.set("x", "<Space>l", [[<S-v>]])
vim.keymap.set("x", "<Space>v", [[v]])
vim.keymap.set("x", "v", [[<ESC>]])
vim.keymap.set("s", "<CR>", [[<ESC>gv"_c]])
vim.keymap.set("s", "j<Space>h", [[<ESC>gv"_c<C-r>+]])
vim.keymap.set("i", "jj", [[<ESC>]], silent)
vim.keymap.set("i", "っｊ", [[<ESC>]], silent)
vim.keymap.set("i", "ｊｊ", [[<ESC>]], silent)
vim.keymap.set("c", "jj", [[<C-c>]], silent)
vim.keymap.set("o", "jj", [[<ESC>]])
vim.keymap.set("s", "jj", [[<ESC>]])
vim.keymap.set("c", "<LeftMouse>", [[<C-c>]])

vim.keymap.set("n", "[indent]f", [[>>]])
vim.keymap.set("x", "[indent]f", [[>gv]])
vim.keymap.set("n", "[indent]l", [[>>]])
vim.keymap.set("x", "[indent]l", [[>gv]])
vim.keymap.set("n", "[indent]a", [[<<]])
vim.keymap.set("x", "[indent]a", [[<gv]])
vim.keymap.set("n", "[indent]h", [[<<]])
vim.keymap.set("x", "[indent]h", [[<gv]])
vim.keymap.set("n", "[indent]s", [[==]])
vim.keymap.set("x", "[indent]s", [[=gv]])
vim.keymap.set("n", "[indent]r", [[<Cmd>left<CR>]])
vim.keymap.set("x", "[indent]r", [[:left<CR>gv]])
local convert_indent_style = function(to_hard)
  local tmp = vim.opt.expandtab
  vim.opt_local.expandtab = not to_hard
  local is_visual = require("misclib.visual_mode").leave()
  local range = is_visual and "'<,'>" or "."
  vim.cmd(range .. "retab!")
  vim.opt.expandtab = tmp
end
vim.keymap.set({ "n", "x" }, "[indent]t", function()
  convert_indent_style(true)
end, silent)
vim.keymap.set({ "n", "x" }, "[indent]<Space>", function()
  convert_indent_style(false)
end, silent)

vim.keymap.set({ "n", "x" }, "k", [[gk]])
vim.keymap.set({ "n", "x" }, "j", [[gj]])
vim.keymap.set({ "n", "x", "o" }, "ge", [[$]])
vim.keymap.set({ "n", "x", "o" }, "ga", [[^]])
vim.keymap.set({ "n", "x", "o" }, "gh", [[0]])
vim.keymap.set({ "n", "x", "o" }, "gz", [[G]])
vim.keymap.set("o", "gp", [[])]])
vim.keymap.set("x", "gp", [[])h]])
vim.keymap.set("o", "gd", [[]}]])
vim.keymap.set("x", "gd", [[]}h]])
vim.keymap.set("o", "gl", "t]")
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
vim.keymap.set("n", "go", [[<C-o>]])
vim.keymap.set("n", "gi", [[<C-i>]])

vim.keymap.set("n", "gO", function()
  return require("notomo.edit").prev_file()
end, { expr = true })
vim.keymap.set("n", "gI", function()
  return require("notomo.edit").next_file()
end, { expr = true })

vim.keymap.set("x", "<S-j>", [[}]])
vim.keymap.set("x", "<S-k>", [[{]])
-- remap for matchit
vim.keymap.set("x", "<S-l>", [[%]], remap)
vim.keymap.set("n", "<S-l>", [[<Cmd>keepjumps normal %<CR>]], silent)
vim.keymap.set("n", "<S-j>", [[<Cmd>keepjumps normal! }<CR>]], silent)
vim.keymap.set("n", "<S-k>", [[<Cmd>keepjumps normal! {<CR>]], silent)
vim.keymap.set("n", "<C-k>", [[<C-b>]])
vim.keymap.set("n", "<C-j>", [[<C-f>]])
vim.keymap.set("n", "<C-e>", [[gi]])
vim.keymap.set("n", "sgj", [[j]m^]])
vim.keymap.set("n", "sgk", [[[m^]])

vim.keymap.set("n", "[newline]o", function()
  for _ in ipairs(vim.fn.range(vim.v.count1)) do
    vim.fn.append(vim.fn.line("."), "")
  end
end, silent)
vim.keymap.set("n", "[newline]j", function()
  for _ in ipairs(vim.fn.range(vim.v.count1)) do
    vim.fn.append(vim.fn.line("."), "")
    vim.cmd([[normal! j]])
  end
end, silent)
vim.keymap.set("n", "<Space>os", [[<Cmd>setlocal spell!<CR>]])
vim.keymap.set("n", "[keyword]v", [[<Cmd>vertical stjump <C-r>=expand('<cword>')<CR><CR>]])
vim.keymap.set("n", "[keyword]t", [[<Cmd>tab stjump <C-r>=expand('<cword>')<CR><CR>]])
vim.keymap.set("n", "[keyword]o", [[<C-]>]])
vim.keymap.set("n", "[keyword]h", [[<Cmd>stjump <C-r>=expand('<cword>')<CR><CR>]])
vim.keymap.set("n", "<F1>", [[<Nop>]])
vim.keymap.set("x", "q", [[<Nop>]])
vim.keymap.set("x", "ZQ", [[<Nop>]])
vim.keymap.set("x", "ZZ", [[<Nop>]])
vim.keymap.set("n", "zD", [[<Nop>]])
vim.keymap.set("n", "<Ins>", [[<Nop>]])
vim.keymap.set("i", "<Ins>", [[<Nop>]])
vim.keymap.set("n", "<RightMouse>", [[<LeftMouse>p]])
vim.keymap.set("v", "<RightMouse>", [[<LeftMouse>p]])
vim.keymap.set("i", "<RightMouse>", [[<LeftMouse><C-r>"]])
vim.keymap.set("n", "<S-LeftMouse>", [[p]])
vim.keymap.set("v", "<S-LeftMouse>", [[p]])
vim.keymap.set("i", "<S-LeftMouse>", [[<C-r>"]])
vim.keymap.set("v", "<3-LeftMouse>", [[y]])
vim.keymap.set("v", "<C-LeftMouse>", [[y]])
vim.keymap.set({ "n", "v", "o" }, "<MiddleMouse>", [[<Nop>]])
vim.keymap.set("i", "<MiddleMouse>", [[<Nop>]])
vim.keymap.set({ "n", "v", "o" }, "<2-MiddleMouse>", [[<Nop>]])
vim.keymap.set("i", "<2-MiddleMouse>", [[<Nop>]])
vim.keymap.set({ "n", "v", "o" }, "<3-MiddleMouse>", [[<Nop>]])
vim.keymap.set("i", "<3-MiddleMouse>", [[<Nop>]])
vim.keymap.set({ "n", "v", "o" }, "<4-MiddleMouse>", [[<Nop>]])
vim.keymap.set("i", "<4-MiddleMouse>", [[<Nop>]])
vim.keymap.set("n", "q", [[<Nop>]])
vim.keymap.set("n", "[edit]w", [[<Cmd>lua require("notomo.diary").open()<CR>]])

local substitute = function(cmd, is_visual)
  return function()
    return require("notomo.edit").gen_substitute(cmd, is_visual)
  end
end
vim.keymap.set("n", "[substitute]f", substitute([[:%s/\v{cursor}//g]], false), expr)
vim.keymap.set("x", "[substitute]f", substitute([[:s/\v%V{cursor}%V//g]], true), expr)
vim.keymap.set("n", "[substitute]wi", substitute([[:%s/\v{word}/{cursor}/g]], false), expr)
vim.keymap.set("n", "[substitute]ww", substitute([[:%s/\v{word}/{word}{cursor}/g]], false), expr)
vim.keymap.set("n", "[substitute]iw", substitute([[:%s/\v{cursor}/{word}/g]], false), expr)
vim.keymap.set("n", "[substitute]vv", substitute([[gv:s/\v%V{word}%V/{word}{cursor}/g]], true), expr)
vim.keymap.set("n", "[substitute]vi", substitute([[gv:s/\v%V{word}%V/{cursor}/g]], true), expr)
vim.keymap.set("n", "[substitute]iv", substitute([[gv:s/\v%V{cursor}%V/{word}/g]], true), expr)
vim.keymap.set("n", "[substitute]yv", substitute([[gv:s/\v%V{register}%V/{word}{cursor}/g]], true), expr)
vim.keymap.set("n", "[substitute]vy", substitute([[gv:s/\v%V{word}%V/{register}{cursor}/g]], true), expr)
vim.keymap.set("n", "[substitute]yi", substitute([[:%s/\v{register}/{cursor}/g]], false), expr)
vim.keymap.set("x", "[substitute]yi", substitute([[:s/\v{register}/{cursor}/g]], true), expr)
vim.keymap.set("n", "[substitute]yy", substitute([[:%s/\v{register}/{register}{cursor}/g]], false), expr)
vim.keymap.set("x", "[substitute]yy", substitute([[:s/\v{register}/{register}{cursor}/g]], true), expr)
vim.keymap.set("n", "[substitute]iy", substitute([[:%s/\v{cursor}/{register}/g]], false), expr)
vim.keymap.set("x", "[substitute]iy", substitute([[:s/\v{cursor}/{register}/g]], true), expr)
vim.keymap.set("n", "[substitute]yw", substitute([[:%s/\v{register}/{word}{cursor}/g]], false), expr)
vim.keymap.set("n", "[substitute]wy", substitute([[:%s/\v{word}/{register}{cursor}/g]], false), expr)
vim.keymap.set("n", "[substitute]c", substitute([[:%s/C\v{cursor}//g]], false), expr)
vim.keymap.set("x", "[substitute]c", substitute([[:s/C\v{cursor}//g]], true), expr)
vim.keymap.set("n", "[substitute]e", substitute([[:%s/\v$/{cursor}/g]], false), expr)
vim.keymap.set("x", "[substitute]e", substitute([[:s/\v$/{cursor}/g]], true), expr)
vim.keymap.set("n", "[substitute]de", substitute([[:g!/{cursor}/d]], false), expr)
vim.keymap.set("x", "[substitute]de", substitute([[:g!/{cursor}/d]], false), expr)
vim.keymap.set("n", "[substitute]di", substitute([[:g/{cursor}/d]], false), expr)
vim.keymap.set("x", "[substitute]di", substitute([[:g/{cursor}/d]], false), expr)

vim.keymap.set("n", "[yank]d", [[<Cmd>lua require("notomo.edit").yank(vim.fn.strftime('%Y-%m-%d'))<CR>]], silent)
vim.keymap.set("n", "[yank]D", [[<Cmd>lua require("notomo.edit").yank(vim.fn.strftime('%Y-%m-%d %T'))<CR>]], silent)
vim.keymap.set(
  "n",
  "[yank]n",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.fnamemodify(vim.fn.expand('%'), ':r'))<CR>]],
  silent
)
vim.keymap.set("n", "[yank]N", [[<Cmd>lua require("notomo.edit").yank(vim.fn.expand('%'))<CR>]], silent)
vim.keymap.set(
  "n",
  "[yank]p",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.substitute(vim.fn.substitute(vim.fn.expand('%:p'), vim.fn.substitute(vim.fn.expand('$HOME'), '\\', '\\\\', 'g'), '~', ''), '\\', '/', 'g'))<CR>]]
)
vim.keymap.set(
  "n",
  "[yank]P",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.substitute(vim.fn.expand('%:p'), '\\', '/', 'g'))<CR>]]
)
vim.keymap.set("n", "[yank];", [[<Cmd>lua require("notomo.edit").yank(vim.fn.getreg(":"))<CR>]], silent)
vim.keymap.set("n", "[yank]/", [[<Cmd>lua require("notomo.edit").yank(vim.fn.getreg("/"))<CR>]], silent)
vim.keymap.set("n", "[yank]i", [[<Cmd>lua require("notomo.edit").yank(vim.fn.getreg("."))<CR>]], silent)
vim.keymap.set(
  "n",
  "[yank]b",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn["gina#component#repo#branch"]())<CR>]],
  silent
)
vim.keymap.set("n", "[yank]l", [[<Cmd>lua require("notomo.edit").yank(vim.fn.line('.'))<CR>]], silent)
vim.keymap.set("n", "[yank]c", [[<Cmd>lua require("notomo.edit").yank(vim.fn.col('.'))<CR>]], silent)
vim.keymap.set("n", "[yank]w", [[<Cmd>lua require("notomo.edit").yank(vim.fn.expand('%:p:h:t'))<CR>]], silent)

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

vim.keymap.set("o", ";", [[iw]])
vim.keymap.set("i", "<C-n>", [[<Down>]])
vim.keymap.set("i", "<C-p>", [[<Up>]])
vim.keymap.set({ "i", "c" }, "<C-b>", [[<Left>]])
vim.keymap.set({ "i", "c" }, "<C-f>", [[<Right>]])
vim.keymap.set("i", "<C-k>", [[<C-o>C]])
vim.keymap.set("c", "<C-k>", [[<Up>]])
vim.keymap.set("c", "<Up>", [[<C-p>]])
vim.keymap.set("c", "<Down>", [[<C-n>]])
vim.keymap.set("c", "<C-j>", [[<Down>]])
vim.keymap.set({ "i", "c" }, "<C-e>", [[<End>]])
vim.keymap.set("i", "<C-a>", [[<C-o>^]])
vim.keymap.set("c", "<C-a>", [[<Home>]])
vim.keymap.set({ "i", "c" }, "<C-h>", [[<BS>]])
vim.keymap.set({ "i", "c" }, "<C-d>", [[<Del>]])
vim.keymap.set("i", "<C-o>", [[<C-o>o]])
vim.keymap.set("i", "<S-TAB>", [[<C-d>]])
vim.keymap.set("i", "j<Space><Space>", [[<ESC>gUiwea]])
vim.keymap.set("i", "j<Space>z", [[<C-a>]])
vim.keymap.set("c", "j<Space>o", [[<Space><BS><C-z>]])
vim.keymap.set("c", "<Tab>", [[<C-n>]])
vim.keymap.set("c", "<S-Tab>", [[<C-p>]])

local set_with_undo = function(mappings)
  for _, m in ipairs(mappings) do
    vim.keymap.set("i", m.lhs, vim.fn.substitute(m.rhs, "\\ze<Left>$", "\\<C-g>U", ""))
  end
end

local MAIN_INPUT_PFX = "j<Space>"
local main_input = {
  { lhs = MAIN_INPUT_PFX .. "a", rhs = "-" },
  { lhs = MAIN_INPUT_PFX .. "e", rhs = "=" },
  { lhs = MAIN_INPUT_PFX .. "s", rhs = "_" },
  { lhs = MAIN_INPUT_PFX .. "r", rhs = "<Bar>" },
  { lhs = MAIN_INPUT_PFX .. "g", rhs = "\\" },
  { lhs = MAIN_INPUT_PFX .. "w", rhs = '""<Left>' },
  { lhs = MAIN_INPUT_PFX .. "b", rhs = "``<Left>" },
  { lhs = MAIN_INPUT_PFX .. "l", rhs = "[]<Left>" },
  { lhs = MAIN_INPUT_PFX .. "L", rhs = "[[]]<Left><Left>" },
  { lhs = MAIN_INPUT_PFX .. "t", rhs = "<><Left>" },
  { lhs = MAIN_INPUT_PFX .. "p", rhs = "()<Left>" },
  { lhs = MAIN_INPUT_PFX .. "d", rhs = "{}<Left>" },
  { lhs = MAIN_INPUT_PFX .. "q", rhs = "''<Left>" },
  { lhs = MAIN_INPUT_PFX .. "h", rhs = "<C-r>+" },
  { lhs = MAIN_INPUT_PFX .. "v", rhs = "<C-q>" },
  { lhs = MAIN_INPUT_PFX .. "c", rhs = "::" },
  { lhs = MAIN_INPUT_PFX .. "fe", rhs = ":=" },
  { lhs = MAIN_INPUT_PFX .. "fq", rhs = "<C-c>" },
  { lhs = MAIN_INPUT_PFX .. "fp", rhs = "<Up><CR>" },
  { lhs = MAIN_INPUT_PFX .. "m", rhs = "<CR>" },
}
set_with_undo(main_input)
for _, m in ipairs(main_input) do
  vim.keymap.set({ "c", "t" }, m.lhs, m.rhs)
end
vim.keymap.set("t", MAIN_INPUT_PFX .. "h", "<Cmd>put +<CR>")
vim.keymap.set("t", MAIN_INPUT_PFX .. "o", "<Tab>")
vim.keymap.set("i", MAIN_INPUT_PFX .. "<CR>", function()
  return require("notomo.edit").to_multiline()
end, { expr = true })

local SUB_INPUT_PFX = "jk"
local sub_input = {
  { lhs = SUB_INPUT_PFX .. "a", rhs = "&" },
  { lhs = SUB_INPUT_PFX .. "h", rhs = "^" },
  { lhs = SUB_INPUT_PFX .. "p", rhs = "+" },
  { lhs = SUB_INPUT_PFX .. "s", rhs = "#" },
  { lhs = SUB_INPUT_PFX .. "r", rhs = "%" },
  { lhs = SUB_INPUT_PFX .. "m", rhs = "@" },
  { lhs = SUB_INPUT_PFX .. "t", rhs = "~" },
  { lhs = SUB_INPUT_PFX .. "d", rhs = "$" },
  { lhs = SUB_INPUT_PFX .. "e", rhs = "!" },
  { lhs = SUB_INPUT_PFX .. "b", rhs = "`" },
  { lhs = SUB_INPUT_PFX .. "c", rhs = ":" },
  { lhs = SUB_INPUT_PFX .. "x", rhs = "*" },
  { lhs = SUB_INPUT_PFX .. "q", rhs = "?" },
  { lhs = SUB_INPUT_PFX .. ";", rhs = '"' },
  { lhs = SUB_INPUT_PFX .. ",", rhs = "'" },
  { lhs = SUB_INPUT_PFX .. "g", rhs = "=>" },
  { lhs = SUB_INPUT_PFX .. "f", rhs = "->" },
  { lhs = SUB_INPUT_PFX .. "z", rhs = "<-" },
  { lhs = SUB_INPUT_PFX .. "v", rhs = "<%=  %><Left><Left><Left>" },
}
set_with_undo(sub_input)
for _, m in ipairs(sub_input) do
  vim.keymap.set({ "c", "t" }, m.lhs, m.rhs)
end
vim.keymap.set({ "i", "c" }, SUB_INPUT_PFX .. "<CR>", "<C-r>=")

local complete_pairs = {
  { "(", ")" },
  { "{", "}" },
  { "[", "]" },
  { "<", ">" },
}
vim.keymap.set("i", "j<Space>k", function()
  local chars = vim.fn.strcharpart(vim.fn.getline("."), vim.fn.col(".") - 2, 2)
  for _, pair in ipairs(complete_pairs) do
    local l, r = unpack(pair)
    if chars == l then
      return r .. "<C-g>U<Left>"
    end
  end
  return "<Right>"
end, expr)
vim.keymap.set({ "n", "x" }, "[diff]j", [[]c]])
vim.keymap.set({ "n", "x" }, "[diff]k", [[[c]])
vim.keymap.set("n", "[diff]g", [[<Cmd>diffget<CR>]])
vim.keymap.set("n", "[diff]p", [[<Cmd>diffput<CR>]])
vim.keymap.set("n", "[diff]q", [[<Cmd>diffoff!<CR>]])
vim.keymap.set("x", "[diff]g", [[:diffget<CR>]])
vim.keymap.set("x", "[diff]p", [[:diffput<CR>]])

vim.keymap.set("n", "[arith]j", function()
  return require("notomo.edit").inc_or_dec(false)
end, expr)
vim.keymap.set("n", "[arith]k", function()
  return require("notomo.edit").inc_or_dec(true)
end, expr)
vim.keymap.set("x", "[arith]j", [[<C-x>gv]])
vim.keymap.set("x", "[arith]k", [[<C-a>gv]])
vim.keymap.set("x", "[arith]d", [[g<C-x>gv]])
vim.keymap.set("x", "[arith]u", [[g<C-a>gv]])
vim.keymap.set("n", "[exec]n", [[<Cmd>nohlsearch<CR>]], silent)
vim.keymap.set("n", "[exec]l", [[':' .. getline('.') .. '<CR>']], expr)
vim.keymap.set("n", "[exec]do", [[<Cmd>tab drop ~/.local/.mytodo<CR>]])
vim.keymap.set("n", "[exec]q", [[<Cmd>lua require("notomo.edit").jq()<CR>]])
vim.keymap.set("n", "[exec]N", [[<Cmd>lua require("notomo.edit").note()<CR>]])

vim.keymap.set("n", "[qf]o", [[<Cmd>lua require("notomo.qf").open()<CR>]])
vim.keymap.set("n", "[qf]n", [[<Cmd>lua require("notomo.qf").next()<CR>]])
vim.keymap.set("n", "[qf]p", [[<Cmd>lua require("notomo.qf").prev()<CR>]])

vim.keymap.set("n", "[winmv]a", [[<C-w>h]])
vim.keymap.set("n", "[winmv]x", [[<C-w>j]])
vim.keymap.set("n", "[winmv]w", [[<C-w>k]])
vim.keymap.set("n", "[winmv]l", [[<C-w>l]])
vim.keymap.set("n", "[winmv]s", [[<C-w>r]])
vim.keymap.set("n", "[winmv];", [[<C-w>w]])

vim.keymap.set("n", "[win]h", [[<Cmd>split<CR>]])
vim.keymap.set("n", "[win]v", [[<Cmd>vsplit<CR>]])
vim.keymap.set("n", "[win]o", [[<Cmd>silent only<CR>]])
vim.keymap.set("n", "[win]q", [[<Cmd>q<CR>]])
vim.keymap.set("n", "[win]e", [[<C-w>=]])

vim.keymap.set("n", "[tab]o", [[<Cmd>silent tabonly<CR>]], silent)
vim.keymap.set("x", "[tab]o", [[<Esc><Cmd>silent tabonly<CR>]], silent)
vim.keymap.set("n", "[tab]O", [[<Cmd>qall<CR>]], silent)
vim.keymap.set("n", "[tab]t", [[<Plug>(new_tab)]], remap)
vim.keymap.set("n", "<C-Tab>", [[gt]])
vim.keymap.set("n", "<C-S-Tab>", [[gT]])
vim.keymap.set("i", "<C-Tab>", [[<Esc>gt]])
vim.keymap.set("i", "<C-S-Tab>", [[<Esc>gT]])
vim.keymap.set("v", "<C-Tab>", [[<Esc>gt]])
vim.keymap.set("v", "<C-S-Tab>", [[<Esc>gT]])
vim.keymap.set("n", "<C-w>", [[<Plug>(tabclose_c)]], silent)
vim.keymap.set("i", "<C-w>", [[<ESC><Plug>(tabclose_c)]], silent_remap)
vim.keymap.set("v", "<C-w>", [[<ESC><Plug>(tabclose_c)]], silent_remap)
vim.keymap.set("n", "<C-t>", [[<Plug>(new_tab)]], silent)
vim.keymap.set("t", "jj", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-p>", [[<Up>]])
vim.keymap.set("t", "<C-n>", [[<Down>]])

if vim.fn.has("win32") == 1 then
  vim.keymap.set("t", "<C-u>", [[<C-Home>]])
end

vim.keymap.set("n", "[term]o", [[<Cmd>terminal<CR>]], silent)
vim.keymap.set("n", "[term]v", [[<Cmd>vsplit|terminal<CR>]], silent)
vim.keymap.set("n", "[term]h", [[<Cmd>split|terminal<CR>]], silent)
vim.keymap.set("n", "[term]t", [[<Cmd>tabedit|terminal<CR>]], silent)
vim.keymap.set("n", "[term]g", function()
  local path = vim.fn.finddir(".git", ",;")
  local project_path = "."
  if path ~= "" then
    project_path = vim.fn.fnamemodify(path, ":p:h:h")
  end
  vim.cmd([[tabedit]])
  vim.fn.termopen(vim.opt.shell:get(), { cwd = project_path })
  vim.cmd([[lcd ]] .. project_path)
end, silent)
vim.keymap.set("t", "<CR>", [[<Cmd>lua require("notomo.edit").set_term_title('^\\$ ', 24)<CR><CR>]])
vim.keymap.set(
  "n",
  "[yank]ud",
  [[<Cmd>lua require("notomo.edit").yank(require('notomo.url').cursor_url_decode())<CR>]],
  silent
)
vim.keymap.set(
  "n",
  "[yank]ue",
  [[<Cmd>lua require("notomo.edit").yank(require('notomo.url').cursor_url_encode())<CR>]],
  silent
)
vim.keymap.set(
  "n",
  "[yank]M",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.trim(vim.fn.system('mongo --eval "(new ObjectId()).str" --quiet')))<CR>]]
)
vim.keymap.set("n", "[term]S", [[<Cmd>lua require("notomo.termdebug").start()<CR>]])
vim.keymap.set("n", "[term]q", [[<Cmd>lua require("notomo.termdebug").quit()<CR>]])
