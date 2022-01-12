local vim = vim
local set = vim.keymap.set

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

set({ "n", "x" }, "x", [["_x]])
set({ "n", "x" }, "[operator]x", [["_d]])
set({ "n", "x" }, "c", [["_c]])

set({ "n", "x" }, "<Space>.", [[@:]])
set("n", "<Leader>r", [[<C-r>]])
set("n", "<Leader>x", [[<Cmd>lua require("notomo.edit").exchange()<CR>]], silent)
set({ "n", "x" }, "[edit]r", [[r]])
set({ "n", "x" }, "[edit]h", [[gU]])
set({ "n", "x" }, "[edit]l", [[gu]])
set("n", "[edit]t", [[viwo<ESC>g~l]])
set("n", "[edit]m", [[i<C-@>]])
set("n", "[edit]j", [[<Cmd>join<CR>]])
set("x", "[edit]j", [[:join<CR>]])
set("n", "[edit]d", [[*N"_cgn]])
set("n", "[edit]a", [[*``cgn<C-r>"]])
set("n", "[edit]p", [[[p]])
set("n", "[edit]P", [[[P]])
set("n", "い", [[i]])
set("n", "あ", [[a]])
set("n", "[file]w", [[<Cmd>write<CR>]])
set("n", "[file]rl", [[:<C-u>edit!<CR>]])
set("n", "[file]R", [[<Cmd>lua require("notomo.edit").rotate_file()<CR>]])

set("n", "[buf]a", [[<C-^>]])

set("n", ";", [[:]])
set("n", ":", [[;]])
set("x", ";", [[:]])
set("x", ":", [[;]])
set("n", "<Space>h", [[<C-v>]])
set("n", "<Space>l", [[<S-v>]])
set("n", "<Space>v", [[gv]])
set("n", "<Space>p", function()
  vim.fn.setpos("'<", { 0, vim.fn.line("'["), vim.fn.col("'[") })
  vim.fn.setpos("'>", { 0, vim.fn.line("']"), vim.fn.col("']") })
  vim.cmd([[normal! gv]])
end)
set("x", "<Space>h", [[<C-v>]])
set("x", "<Space>l", [[<S-v>]])
set("x", "<Space>v", [[v]])
set("x", "v", [[<ESC>]])
set("s", "<CR>", [[<ESC>gv"_c]])
set("s", "j<Space>h", [[<ESC>gv"_c<C-r>+]])
set("i", "jj", [[<ESC>]], silent)
set("i", "っｊ", [[<ESC>]], silent)
set("i", "ｊｊ", [[<ESC>]], silent)
set("c", "jj", [[<C-c>]], silent)
set("o", "jj", [[<ESC>]])
set("s", "jj", [[<ESC>]])
set("c", "<LeftMouse>", [[<C-c>]])

set("n", "[indent]f", [[>>]])
set("x", "[indent]f", [[>gv]])
set("n", "[indent]l", [[>>]])
set("x", "[indent]l", [[>gv]])
set("n", "[indent]a", [[<<]])
set("x", "[indent]a", [[<gv]])
set("n", "[indent]h", [[<<]])
set("x", "[indent]h", [[<gv]])
set("n", "[indent]s", [[==]])
set("x", "[indent]s", [[=gv]])
set("n", "[indent]r", [[<Cmd>left<CR>]])
set("x", "[indent]r", [[:left<CR>gv]])
local convert_indent_style = function(to_hard)
  local tmp = vim.opt.expandtab
  vim.opt_local.expandtab = not to_hard
  local is_visual = require("notomo.mode").leave_visual_mode()
  local range = is_visual and "'<,'>" or "."
  vim.cmd(range .. "retab!")
  vim.opt.expandtab = tmp
end
set({ "n", "x" }, "[indent]t", function()
  convert_indent_style(true)
end, silent)
set({ "n", "x" }, "[indent]<Space>", function()
  convert_indent_style(false)
end, silent)

set({ "n", "x" }, "k", [[gk]])
set({ "n", "x" }, "j", [[gj]])
set({ "n", "x", "o" }, "ge", [[$]])
set({ "n", "x", "o" }, "ga", [[^]])
set({ "n", "x", "o" }, "gh", [[0]])
set({ "n", "x", "o" }, "gz", [[G]])
set("o", "gp", [[])]])
set("x", "gp", [[])h]])
set("o", "gd", [[]}]])
set("x", "gd", [[]}h]])
set("o", "gl", "t]")
set("o", "gs", [[t"]])
set("o", "gb", [[t`]])
set("o", "gq", [[t']])
set("o", "gx", [[t*]])
set("o", "gt", [[t>]])
set("o", "g;", [[t;]])
set("o", "g,", [[t,]])
set("o", "g.", [[t.]])
set("o", "gc", [[t:]])
set("o", "gP", [[t(]])
set("n", "go", [[<C-o>]])
set("n", "gi", [[<C-i>]])
set("n", "gO", [[g;]])
set("n", "gI", [[g,]])
set("x", "<S-j>", [[}]])
set("x", "<S-k>", [[{]])
-- remap for matchit
set("x", "<S-l>", [[%]], remap)
set("n", "<S-l>", [[<Cmd>keepjumps normal %<CR>]], silent)
set("n", "<S-j>", [[<Cmd>keepjumps normal! }<CR>]], silent)
set("n", "<S-k>", [[<Cmd>keepjumps normal! {<CR>]], silent)
set("n", "<C-k>", [[<C-b>]])
set("n", "<C-j>", [[<C-f>]])
set("n", "<C-e>", [[gi]])
set("n", "sgj", [[j]m^]])
set("n", "sgk", [[[m^]])

set("n", "[newline]o", function()
  for _ in ipairs(vim.fn.range(vim.v.count1)) do
    vim.fn.append(vim.fn.line("."), "")
  end
end, silent)
set("n", "[newline]j", function()
  for _ in ipairs(vim.fn.range(vim.v.count1)) do
    vim.fn.append(vim.fn.line("."), "")
    vim.cmd([[normal! j]])
  end
end, silent)
set("n", "<Space>os", [[<Cmd>setlocal spell!<CR>]])
set("n", "[keyword]v", [[<Cmd>vertical stjump <C-r>=expand('<cword>')<CR><CR>]])
set("n", "[keyword]t", [[<Cmd>tab stjump <C-r>=expand('<cword>')<CR><CR>]])
set("n", "[keyword]o", [[<C-]>]])
set("n", "[keyword]h", [[<Cmd>stjump <C-r>=expand('<cword>')<CR><CR>]])
set("n", "<F1>", [[<Nop>]])
set("x", "q", [[<Nop>]])
set("x", "ZQ", [[<Nop>]])
set("x", "ZZ", [[<Nop>]])
set("n", "zD", [[<Nop>]])
set("n", "<Ins>", [[<Nop>]])
set("i", "<Ins>", [[<Nop>]])
set("n", "<RightMouse>", [[<LeftMouse>p]])
set("v", "<RightMouse>", [[<LeftMouse>p]])
set("i", "<RightMouse>", [[<LeftMouse><C-r>"]])
set("n", "<S-LeftMouse>", [[p]])
set("v", "<S-LeftMouse>", [[p]])
set("i", "<S-LeftMouse>", [[<C-r>"]])
set("v", "<3-LeftMouse>", [[y]])
set("v", "<C-LeftMouse>", [[y]])
set({ "n", "v", "o" }, "<MiddleMouse>", [[<Nop>]])
set("i", "<MiddleMouse>", [[<Nop>]])
set({ "n", "v", "o" }, "<2-MiddleMouse>", [[<Nop>]])
set("i", "<2-MiddleMouse>", [[<Nop>]])
set({ "n", "v", "o" }, "<3-MiddleMouse>", [[<Nop>]])
set("i", "<3-MiddleMouse>", [[<Nop>]])
set({ "n", "v", "o" }, "<4-MiddleMouse>", [[<Nop>]])
set("i", "<4-MiddleMouse>", [[<Nop>]])
set("n", "q", [[<Nop>]])
set("n", "[edit]w", [[<Cmd>lua require("notomo.diary").open()<CR>]])

local substitute = function(cmd, is_visual)
  return function()
    return require("notomo.edit").gen_substitute(cmd, is_visual)
  end
end
set("n", "[substitute]f", substitute([[:%s/\v{cursor}//g]], false), expr)
set("x", "[substitute]f", substitute([[:s/\v%V{cursor}%V//g]], true), expr)
set("n", "[substitute]wi", substitute([[:%s/\v{word}/{cursor}/g]], false), expr)
set("n", "[substitute]ww", substitute([[:%s/\v{word}/{word}{cursor}/g]], false), expr)
set("n", "[substitute]iw", substitute([[:%s/\v{cursor}/{word}/g]], false), expr)
set("n", "[substitute]vv", substitute([[gv:s/\v%V{word}%V/{word}{cursor}/g]], true), expr)
set("n", "[substitute]vi", substitute([[gv:s/\v%V{word}%V/{cursor}/g]], true), expr)
set("n", "[substitute]iv", substitute([[gv:s/\v%V{cursor}%V/{word}/g]], true), expr)
set("n", "[substitute]yv", substitute([[gv:s/\v%V{register}%V/{word}{cursor}/g]], true), expr)
set("n", "[substitute]vy", substitute([[gv:s/\v%V{word}%V/{register}{cursor}/g]], true), expr)
set("n", "[substitute]yi", substitute([[:%s/\v{register}/{cursor}/g]], false), expr)
set("x", "[substitute]yi", substitute([[:s/\v{register}/{cursor}/g]], true), expr)
set("n", "[substitute]yy", substitute([[:%s/\v{register}/{register}{cursor}/g]], false), expr)
set("x", "[substitute]yy", substitute([[:s/\v{register}/{register}{cursor}/g]], true), expr)
set("n", "[substitute]iy", substitute([[:%s/\v{cursor}/{register}/g]], false), expr)
set("x", "[substitute]iy", substitute([[:s/\v{cursor}/{register}/g]], true), expr)
set("n", "[substitute]yw", substitute([[:%s/\v{register}/{word}{cursor}/g]], false), expr)
set("n", "[substitute]wy", substitute([[:%s/\v{word}/{register}{cursor}/g]], false), expr)
set("n", "[substitute]c", substitute([[:%s/C\v{cursor}//g]], false), expr)
set("x", "[substitute]c", substitute([[:s/C\v{cursor}//g]], true), expr)
set("n", "[substitute]e", substitute([[:%s/\v$/{cursor}/g]], false), expr)
set("x", "[substitute]e", substitute([[:s/\v$/{cursor}/g]], true), expr)
set("n", "[substitute]de", substitute([[:v/{cursor}/d]], false), expr)
set("x", "[substitute]de", substitute([[:v/{cursor}/d]], false), expr)
set("n", "[substitute]di", substitute([[:g/{cursor}/d]], false), expr)
set("x", "[substitute]di", substitute([[:g/{cursor}/d]], false), expr)

set("n", "[yank]d", [[<Cmd>lua require("notomo.edit").yank(vim.fn.strftime('%Y-%m-%d'))<CR>]], silent)
set("n", "[yank]D", [[<Cmd>lua require("notomo.edit").yank(vim.fn.strftime('%Y-%m-%d %T'))<CR>]], silent)
set("n", "[yank]n", [[<Cmd>lua require("notomo.edit").yank(vim.fn.fnamemodify(vim.fn.expand('%'), ':r'))<CR>]], silent)
set("n", "[yank]N", [[<Cmd>lua require("notomo.edit").yank(vim.fn.expand('%'))<CR>]], silent)
set(
  "n",
  "[yank]p",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.substitute(vim.fn.substitute(vim.fn.expand('%:p'), vim.fn.substitute(vim.fn.expand('$HOME'), '\\', '\\\\', 'g'), '~', ''), '\\', '/', 'g'))<CR>]]
)
set(
  "n",
  "[yank]P",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.substitute(vim.fn.expand('%:p'), '\\', '/', 'g'))<CR>]]
)
set("n", "[yank];", [[<Cmd>lua require("notomo.edit").yank(vim.fn.getreg(":"))<CR>]], silent)
set("n", "[yank]/", [[<Cmd>lua require("notomo.edit").yank(vim.fn.getreg("/"))<CR>]], silent)
set("n", "[yank]i", [[<Cmd>lua require("notomo.edit").yank(vim.fn.getreg("."))<CR>]], silent)
set("n", "[yank]b", [[<Cmd>lua require("notomo.edit").yank(vim.fn["gina#component#repo#branch"]())<CR>]], silent)
set("n", "[yank]l", [[<Cmd>lua require("notomo.edit").yank(vim.fn.line('.'))<CR>]], silent)
set("n", "[yank]c", [[<Cmd>lua require("notomo.edit").yank(vim.fn.col('.'))<CR>]], silent)
set("n", "[yank]w", [[<Cmd>lua require("notomo.edit").yank(vim.fn.expand('%:p:h:t'))<CR>]], silent)

local set_ia_xo = function(lhs, rhs)
  local inner_lhs = "i" .. lhs
  local inner_rhs = "i" .. rhs
  local around_lhs = "a" .. lhs
  local around_rhs = "a" .. rhs
  set({ "x", "o" }, inner_lhs, inner_rhs)
  set({ "x", "o" }, around_lhs, around_rhs)
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

set("o", ";", [[iw]])
set("i", "<C-n>", [[<Down>]])
set("i", "<C-p>", [[<Up>]])
set({ "i", "c" }, "<C-b>", [[<Left>]])
set({ "i", "c" }, "<C-f>", [[<Right>]])
set("i", "<C-k>", [[<C-o>C]])
set("c", "<C-k>", [[<Up>]])
set("c", "<Up>", [[<C-p>]])
set("c", "<Down>", [[<C-n>]])
set("c", "<C-j>", [[<Down>]])
set({ "i", "c" }, "<C-e>", [[<End>]])
set("i", "<C-a>", [[<C-o>^]])
set("c", "<C-a>", [[<Home>]])
set({ "i", "c" }, "<C-h>", [[<BS>]])
set({ "i", "c" }, "<C-d>", [[<Del>]])
set("i", "<C-o>", [[<C-o>o]])
set("i", "<S-TAB>", [[<C-d>]])
set("i", "j<Space><Space>", [[<ESC>gUiwea]])
set("i", "j<Space>z", [[<C-a>]])
set("c", "j<Space>o", [[<Space><BS><C-z>]])
set("c", "<Tab>", [[<C-n>]])
set("c", "<S-Tab>", [[<C-p>]])

require("notomo.mapping").set_main_input()
require("notomo.mapping").set_sub_input()

local complete_pairs = {
  { "(", ")" },
  { "{", "}" },
  { "[", "]" },
  { "<", ">" },
}
set("i", "j<Space>k", function()
  local chars = vim.fn.strcharpart(vim.fn.getline("."), vim.fn.col(".") - 2, 2)
  for _, pair in ipairs(complete_pairs) do
    local l, r = unpack(pair)
    if chars == l then
      return r .. "<C-g>U<Left>"
    end
  end
  return "<Right>"
end, expr)
set({ "n", "x" }, "[diff]j", [[]c]])
set({ "n", "x" }, "[diff]k", [[[c]])
set("n", "[diff]g", [[<Cmd>diffget<CR>]])
set("n", "[diff]p", [[<Cmd>diffput<CR>]])
set("n", "[diff]q", [[<Cmd>diffoff!<CR>]])
set("x", "[diff]g", [[:diffget<CR>]])
set("x", "[diff]p", [[:diffput<CR>]])

set("n", "[arith]j", function()
  return require("notomo.edit").inc_or_dec(false)
end, expr)
set("n", "[arith]k", function()
  return require("notomo.edit").inc_or_dec(true)
end, expr)
set("x", "[arith]j", [[<C-x>gv]])
set("x", "[arith]k", [[<C-a>gv]])
set("x", "[arith]d", [[g<C-x>gv]])
set("x", "[arith]u", [[g<C-a>gv]])
set("n", "[exec]n", [[<Cmd>nohlsearch<CR>]], silent)
set("n", "[exec]l ", [[':' .. getline('.') .. '<CR>']], expr)
set("n", "[exec]do", [[<Cmd>tab drop ~/.local/.mytodo<CR>]])
set("n", "[exec]q", [[<Cmd>lua require("notomo.edit").jq()<CR>]])
set("n", "[exec]N", [[<Cmd>lua require("notomo.edit").note()<CR>]])

set("n", "[qf]o", [[<Cmd>lua require("notomo.qf").open()<CR>]])
set("n", "[qf]n", [[<Cmd>lua require("notomo.qf").next()<CR>]])
set("n", "[qf]p", [[<Cmd>lua require("notomo.qf").prev()<CR>]])

set("n", "[winmv]a", [[<C-w>h]])
set("n", "[winmv]x", [[<C-w>j]])
set("n", "[winmv]w", [[<C-w>k]])
set("n", "[winmv]l", [[<C-w>l]])
set("n", "[winmv]s", [[<C-w>r]])
set("n", "[winmv];", [[<C-w>w]])

set("n", "[win]h", [[<Cmd>split<CR>]])
set("n", "[win]v", [[<Cmd>vsplit<CR>]])
set("n", "[win]o", [[<Cmd>silent only<CR>]])
set("n", "[win]q", [[<Cmd>q<CR>]])
set("n", "[win]e", [[<C-w>=]])

set("n", "[tab]o", [[<Cmd>silent tabonly<CR>]], silent)
set("x", "[tab]o", [[<Esc><Cmd>silent tabonly<CR>]], silent)
set("n", "[tab]O", [[<Cmd>qall<CR>]], silent)
set("n", "[tab]t", [[<Plug>(new_tab)]], remap)
set("n", "<C-Tab>", [[gt]])
set("n", "<C-S-Tab>", [[gT]])
set("i", "<C-Tab>", [[<Esc>gt]])
set("i", "<C-S-Tab>", [[<Esc>gT]])
set("v", "<C-Tab>", [[<Esc>gt]])
set("v", "<C-S-Tab>", [[<Esc>gT]])
set("n", "<C-w>", [[<Plug>(tabclose_c)]], silent)
set("i", "<C-w>", [[<ESC><Plug>(tabclose_c)]], silent_remap)
set("v", "<C-w>", [[<ESC><Plug>(tabclose_c)]], silent_remap)
set("n", "<C-t>", [[<Plug>(new_tab)]], silent)
set("t", "jj", [[<C-\><C-n>]])
set("t", "<C-p>", [[<Up>]])
set("t", "<C-n>", [[<Down>]])

require("notomo.mapping").set_tab()

if vim.fn.has("win32") == 1 then
  set("t", "<C-u>", [[<C-Home>]])
end

set("n", "[term]o", [[<Cmd>terminal<CR>]], silent)
set("n", "[term]v", [[<Cmd>vsplit|terminal<CR>]], silent)
set("n", "[term]h", [[<Cmd>split|terminal<CR>]], silent)
set("n", "[term]t", [[<Cmd>tabedit|terminal<CR>]], silent)
set("n", "[term]g", function()
  local path = vim.fn.finddir(".git", ",;")
  local project_path = "."
  if path ~= "" then
    project_path = vim.fn.fnamemodify(path, ":p:h:h")
  end
  vim.cmd([[tabedit]])
  vim.fn.termopen(vim.opt.shell:get(), { cwd = project_path })
  vim.cmd([[lcd ]] .. project_path)
end, silent)
set("t", "<CR>", [[<Cmd>lua require("notomo.edit").set_term_title('^\\$ ', 24)<CR><CR>]])
set("n", "[yank]ud", [[<Cmd>lua require("notomo.edit").yank(require('notomo.url').cursor_url_decode())<CR>]], silent)
set("n", "[yank]ue", [[<Cmd>lua require("notomo.edit").yank(require('notomo.url').cursor_url_encode())<CR>]], silent)
set(
  "n",
  "[yank]M",
  [[<Cmd>lua require("notomo.edit").yank(vim.fn.trim(vim.fn.system('mongo --eval "(new ObjectId()).str" --quiet')))<CR>]]
)
set("n", "[term]S", [[<Cmd>lua require("notomo.termdebug").start()<CR>]])
set("n", "[term]q", [[<Cmd>lua require("notomo.termdebug").quit()<CR>]])
