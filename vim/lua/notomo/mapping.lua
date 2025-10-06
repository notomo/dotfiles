vim.g.mapleader = ","
vim.g.maplocalleader = "<Leader>l"

vim.keymap.set({ "n", "x" }, "[exec]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space>x", "[exec]", { remap = true })

vim.keymap.set({ "n", "x" }, "[keyword]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space>k", "[keyword]", { remap = true })

vim.keymap.set({ "n", "x" }, "[diff]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Leader>d", "[diff]", { remap = true })

vim.keymap.set({ "n", "x" }, "[edit]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space>e", "[edit]", { remap = true })

vim.keymap.set({ "n" }, "[file]", "<Nop>")
vim.keymap.set({ "n" }, "<Space>f", "[file]", { remap = true })

vim.keymap.set({ "n", "x" }, "[operator]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space><Leader>", "[operator]", { remap = true })

vim.keymap.set({ "n", "x" }, "[git]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Leader>g", "[git]", { remap = true })

vim.keymap.set({ "n", "x" }, "[test]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Leader>t", "[test]", { remap = true })

vim.keymap.set({ "n", "x" }, "[substitute]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space>s", "[substitute]", { remap = true })

vim.keymap.set({ "n", "x" }, "[finder]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space>d", "[finder]", { remap = true })

vim.keymap.set({ "n" }, "[buf]", "<Nop>")
vim.keymap.set({ "n" }, "<Space>b", "[buf]", { remap = true })

vim.keymap.set({ "n", "x" }, "[indent]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space>i", "[indent]", { remap = true })

vim.keymap.set({ "n" }, "[winmv]", "<Nop>")
vim.keymap.set({ "n" }, "m", "[winmv]", { remap = true })

vim.keymap.set({ "n" }, "[win]", "<Nop>")
vim.keymap.set({ "n" }, "<Space>w", "[win]", { remap = true })

vim.keymap.set({ "n", "x" }, "[tab]", "<Nop>")
vim.keymap.set({ "n", "x" }, "t", "[tab]", { remap = true })

vim.keymap.set({ "n" }, "[term]", "<Nop>")
vim.keymap.set({ "n" }, "<Space>t", "[term]", { remap = true })

vim.keymap.set({ "n", "x" }, "[arith]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space>a", "[arith]", { remap = true })

vim.keymap.set({ "n", "x" }, "[yank]", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Space>y", "[yank]", { remap = true })

vim.keymap.set({ "n" }, "[newline]", "<Nop>")
vim.keymap.set({ "n" }, "o", "[newline]", { remap = true })

vim.keymap.set({ "n", "x" }, "x", [["_x]])
vim.keymap.set({ "n", "x" }, "[operator]x", [["_d]])
vim.keymap.set({ "n", "x" }, "c", [["_c]])

vim.keymap.set({ "n", "x" }, "<Space>.", [[@:]])
vim.keymap.set("n", "<Leader>r", [[<C-r>]])
vim.keymap.set("n", "<Leader>x", [[<Cmd>lua require("notomo.lib.edit").exchange()<CR>]], { silent = true })
vim.keymap.set({ "n", "x" }, "[edit]r", [[r]])
vim.keymap.set({ "n", "x" }, "[edit]h", [[gU]])
vim.keymap.set({ "n", "x" }, "[edit]l", [[gu]])
vim.keymap.set("n", "[edit]t", [[viwo<ESC>g~l]])
vim.keymap.set("n", "[edit]m", [[i<C-@>]])

vim.keymap.set("n", "[edit]j", function()
  local search_pattern = [[/\v\n\s*<CR>]]
  local delete_next = [["_dgn]]
  local disable_highlight = ":nohlsearch<CR>"
  local current_column = vim.fn.col(".")
  local last_column = vim.fn.col("$")
  if current_column == last_column - 1 or current_column == last_column then
    return search_pattern .. "N" .. delete_next .. disable_highlight
  end
  return search_pattern .. delete_next .. disable_highlight
end, { expr = true })
vim.keymap.set("x", "[edit]j", [[:join<CR>]])

vim.keymap.set("n", "[edit]d", [[*N"_cgn]])
vim.keymap.set("n", "[edit]a", [[*``cgn<C-r>"]])
vim.keymap.set("n", "[edit]p", [[[p]])
vim.keymap.set("n", "[edit]P", [[[P]])
vim.keymap.set("n", "い", [[i]])
vim.keymap.set("n", "あ", [[a]])
vim.keymap.set("n", "[file]w", [[<Cmd>write<CR>]])
vim.keymap.set("n", "[file]rl", function()
  local view = vim.fn.winsaveview()
  local ok, err = pcall(vim.cmd.edit, { bang = true })
  ---@diagnostic disable-next-line: need-check-nil
  if not ok and not err:match("No file name") then
    error(err)
  end
  vim.api.nvim_echo({ { "reloaded" } }, false, {})
  vim.fn.winrestview(view)

  vim.api.nvim_exec_autocmds("User", { pattern = "NotomoReloaded", modeline = false })
end)
vim.keymap.set("n", "[file]R", [[<Cmd>lua require("notomo.lib.edit").rotate_file()<CR>]])

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
  vim.cmd.normal({ args = { "gv" }, bang = true })
end)
vim.keymap.set("x", "<Space>h", [[<C-v>]])
vim.keymap.set("x", "<Space>l", [[<S-v>]])
vim.keymap.set("x", "<Space>v", [[v]])
vim.keymap.set("x", "v", [[<ESC>]])
vim.keymap.set("x", "q", [[<ESC>]])
vim.keymap.set("s", "<CR>", [[<ESC>gv"_c]])
vim.keymap.set("i", "jj", [[<ESC>]], { silent = true })
vim.keymap.set("i", "っｊ", [[<ESC>]], { silent = true })
vim.keymap.set("i", "ｊｊ", [[<ESC>]], { silent = true })
vim.keymap.set("c", "jj", [[<C-c>]], { silent = true })
vim.keymap.set("o", "jj", [[<ESC>]])
vim.keymap.set("s", "jj", [[<ESC>]])
vim.keymap.set("c", "<LeftMouse>", [[<C-c>]])

vim.keymap.set("n", "zj", function()
  vim.cmd.normal({ args = { "zr" }, bang = true })
  vim.notify(("foldlevel: %d"):format(vim.wo.foldlevel))
end)
vim.keymap.set("n", "zk", function()
  vim.cmd.normal({ args = { "zm" }, bang = true })
  vim.notify(("foldlevel: %d"):format(vim.wo.foldlevel))
end)

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
end, { silent = true })
vim.keymap.set({ "n", "x" }, "[indent]<Space>", function()
  convert_indent_style(false)
end, { silent = true })

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
vim.keymap.set("n", "g;", function()
  local last = vim.api.nvim_buf_get_mark(0, "^")
  if last[1] > 0 then
    vim.cmd.normal({ args = { "m'" }, bang = true })
    require("misclib.cursor").set(last)
  end
end)

vim.keymap.set("x", "<S-j>", [[}]])
vim.keymap.set("x", "<S-k>", [[{]])
-- remap for matchit
vim.keymap.set("x", "<S-l>", [[%]], { remap = true })
vim.keymap.set("n", "<S-l>", [[<Cmd>keepjumps normal %<CR>]], { silent = true })
vim.keymap.set("n", "<S-j>", [[<Cmd>keepjumps normal! }<CR>]], { silent = true })
vim.keymap.set("n", "<S-k>", [[<Cmd>keepjumps normal! {<CR>]], { silent = true })
vim.keymap.set("n", "<C-k>", [[<C-b>]])
vim.keymap.set("n", "<C-j>", [[<C-f>]])
vim.keymap.set("n", "<C-e>", [[gi]])
vim.keymap.set("n", "sgj", [[j]m^]])
vim.keymap.set("n", "sgk", [[[m^]])

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
vim.keymap.set("n", "<Space>os", [[<Cmd>setlocal spell!<CR>]])
vim.keymap.set("n", "[keyword]v", [[:<C-u>vertical stjump <C-r>=expand('<cword>')<CR><CR>]])
vim.keymap.set("n", "[keyword]t", [[:<C-u>tab stjump <C-r>=expand('<cword>')<CR><CR>]])
vim.keymap.set("n", "[keyword]o", [[<C-]>]])
vim.keymap.set("n", "[keyword]h", [[:<C-u>stjump <C-r>=expand('<cword>')<CR><CR>]])
vim.keymap.set("n", "<F1>", [[<Nop>]])
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
vim.keymap.set("n", "[edit]w", [[<Cmd>lua require("notomo.lib.diary").open()<CR>]])

local substitute = function(cmd, is_visual)
  return function()
    return require("notomo.lib.edit").gen_substitute(cmd, is_visual)
  end
end
vim.keymap.set("n", "[substitute]f", substitute([[:%s/\v{cursor}//g]], false), { expr = true })
vim.keymap.set("x", "[substitute]f", substitute([[:s/\v%V{cursor}%V//g]], true), { expr = true })
vim.keymap.set("n", "[substitute]wi", substitute([[:%s/\v{word}/{cursor}/g]], false), { expr = true })
vim.keymap.set("n", "[substitute]ww", substitute([[:%s/\v{word}/{word}{cursor}/g]], false), { expr = true })
vim.keymap.set("n", "[substitute]iw", substitute([[:%s/\v{cursor}/{word}/g]], false), { expr = true })
vim.keymap.set("n", "[substitute]vv", substitute([[gv:s/\v%V{word}%V/{word}{cursor}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]vi", substitute([[gv:s/\v%V{word}%V/{cursor}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]iv", substitute([[gv:s/\v%V{cursor}%V/{word}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]yv", substitute([[gv:s/\v%V{register}%V/{word}{cursor}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]vy", substitute([[gv:s/\v%V{word}%V/{register}{cursor}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]yi", substitute([[:%s/\v{register}/{cursor}/g]], false), { expr = true })
vim.keymap.set("x", "[substitute]yi", substitute([[:s/\v{register}/{cursor}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]yy", substitute([[:%s/\v{register}/{register}{cursor}/g]], false), { expr = true })
vim.keymap.set("x", "[substitute]yy", substitute([[:s/\v{register}/{register}{cursor}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]iy", substitute([[:%s/\v{cursor}/{register}/g]], false), { expr = true })
vim.keymap.set("x", "[substitute]iy", substitute([[:s/\v{cursor}/{register}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]yw", substitute([[:%s/\v{register}/{word}{cursor}/g]], false), { expr = true })
vim.keymap.set("n", "[substitute]wy", substitute([[:%s/\v{word}/{register}{cursor}/g]], false), { expr = true })
vim.keymap.set("n", "[substitute]c", substitute([[:%s/C\v{cursor}//g]], false), { expr = true })
vim.keymap.set("x", "[substitute]c", substitute([[:s/C\v{cursor}//g]], true), { expr = true })
vim.keymap.set("n", "[substitute]e", substitute([[:%s/\v$/{cursor}/g]], false), { expr = true })
vim.keymap.set("x", "[substitute]e", substitute([[:s/\v$/{cursor}/g]], true), { expr = true })
vim.keymap.set("n", "[substitute]de", substitute([[:g!/{cursor}/d]], false), { expr = true })
vim.keymap.set("x", "[substitute]de", substitute([[:g!/{cursor}/d]], false), { expr = true })
vim.keymap.set("n", "[substitute]di", substitute([[:g/{cursor}/d]], false), { expr = true })
vim.keymap.set("x", "[substitute]di", substitute([[:g/{cursor}/d]], false), { expr = true })
vim.keymap.set("n", "[substitute]do", substitute([[:%s/\v(.{-}({cursor}).*|^.*\n)/\2/g]], false), { expr = true })

vim.keymap.set(
  "n",
  "[yank]d",
  [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.strftime('%Y-%m-%d'))<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[yank]D",
  [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.strftime('%Y-%m-%d %T'))<CR>]],
  { silent = true }
)
vim.keymap.set("n", "[yank]n", function()
  local path = vim.fn.expand("%")
  if vim.bo.filetype == "kivi-file" then
    path = vim.fs.basename(vim.fs.normalize(vim.fn.getcwd()))
  end
  require("notomo.lib.edit").yank(vim.fn.fnamemodify(path, ":r"))
end, { silent = true })
vim.keymap.set("n", "[yank]N", function()
  local path = vim.api.nvim_buf_get_name(0)
  if vim.bo.filetype == "kivi-file" then
    path = vim.fn.getcwd()
  end
  require("notomo.lib.edit").yank(vim.fs.basename(path))
end, { silent = true })
vim.keymap.set("n", "[yank]p", function()
  local home = vim.fs.normalize("$HOME")
  local path = vim.fs.normalize(vim.fn.expand("%:p"))
  if vim.bo.filetype == "kivi-file" then
    path = vim.fs.normalize(vim.fn.getcwd())
  end
  ---@diagnostic disable-next-line: cast-local-type
  path = vim.fn.substitute(path, "^" .. home, "~", "")
  require("notomo.lib.edit").yank(path)
end)
vim.keymap.set("n", "[yank]g", function()
  local git_root = vim.fs.root(0, ".git") or "."
  local path = vim.fs.normalize(vim.fn.expand("%:p"))
  if vim.bo.filetype == "kivi-file" then
    path = vim.fs.normalize(vim.fn.getcwd())
  end
  local relative_path = vim.fs.relpath(git_root, path)
  require("notomo.lib.edit").yank(relative_path)
end)
vim.keymap.set(
  "x",
  "[yank]T",
  [[<Cmd>lua require("notomo.lib.edit").yank(require("notomo.lib.treesitter.node").expr())<CR>]]
)
vim.keymap.set("n", "[yank]P", function()
  local path = vim.fs.normalize(vim.fn.expand("%:p"))
  if vim.bo.filetype == "kivi-file" then
    path = vim.fs.normalize(vim.fn.getcwd())
  end
  require("notomo.lib.edit").yank(path)
end)
vim.keymap.set("n", "[yank];", [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.getreg(":"))<CR>]], { silent = true })
vim.keymap.set("n", "[yank]/", [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.getreg("/"))<CR>]], { silent = true })
vim.keymap.set("n", "[yank]i", [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.getreg("."))<CR>]], { silent = true })
vim.keymap.set(
  "n",
  "[yank]b",
  [[<Cmd>lua require("notomo.lib.edit").yank(require("notomo.lib.git").current_branch())<CR>]],
  { silent = true }
)
vim.keymap.set("n", "[yank]l", [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.line('.'))<CR>]], { silent = true })
vim.keymap.set("n", "[yank]c", [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.col('.'))<CR>]], { silent = true })
vim.keymap.set("n", "[yank]w", function()
  require("notomo.lib.edit").yank(vim.fs.basename(vim.fn.getcwd()))
end, { silent = true })
vim.keymap.set("n", "[yank]s", function()
  local git_root = vim.fs.root(0, ".git") or "."
  local path = vim.fs.normalize(vim.fn.expand("%:p"))
  if vim.bo.filetype == "kivi-file" then
    path = vim.fs.normalize(vim.fn.getcwd())
  end
  local relative_path = vim.fs.relpath(git_root, path)
  require("notomo.lib.edit").yank("#file:" .. relative_path)
end)

vim.keymap.set({ "x", "o" }, "io", "ip")
vim.keymap.set({ "x", "o" }, "ao", "ap")

vim.keymap.set({ "x", "o" }, "i;", "iw")
vim.keymap.set({ "x", "o" }, "a;", "aw")

vim.keymap.set({ "x", "o" }, "i<Space>", "iW")
vim.keymap.set({ "x", "o" }, "a<Space>", "aW")

vim.keymap.set({ "x", "o" }, "it", "i>")
vim.keymap.set({ "x", "o" }, "at", "a>")

vim.keymap.set({ "x", "o" }, "iT", "it")
vim.keymap.set({ "x", "o" }, "aT", "at")

vim.keymap.set({ "x", "o" }, "ip", "i)")
vim.keymap.set({ "x", "o" }, "ap", "a)")

vim.keymap.set({ "x", "o" }, "il", "i]")
vim.keymap.set({ "x", "o" }, "al", "a]")

vim.keymap.set({ "x", "o" }, "iw", 'i"')
vim.keymap.set({ "x", "o" }, "aw", 'a"')

vim.keymap.set({ "x", "o" }, "iq", "i'")
vim.keymap.set({ "x", "o" }, "aq", "a'")

vim.keymap.set({ "x", "o" }, "id", "i}")
vim.keymap.set({ "x", "o" }, "ad", "a}")

vim.keymap.set({ "x", "o" }, "ib", "i`")
vim.keymap.set({ "x", "o" }, "ab", "a`")

vim.keymap.set({ "x", "o" }, "i<CR>", "iB")
vim.keymap.set({ "x", "o" }, "a<CR>", "aB")

vim.keymap.set("o", ";", [[iw]])
vim.keymap.set("i", "<C-n>", [[<Down>]])
vim.keymap.set("i", "<C-p>", [[<Up>]])
vim.keymap.set("i", "<C-f>", [[<C-g>U<Right>]])
vim.keymap.set("i", "<C-b>", [[<C-g>U<Left>]])
vim.keymap.set("c", "<C-b>", [[<Left>]])
vim.keymap.set("c", "<C-f>", [[<Right>]])
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
vim.keymap.set("c", "<Tab>", [[<C-n>]])
vim.keymap.set("c", "<S-Tab>", [[<C-p>]])

vim.keymap.set({ "i", "c", "t", "s" }, "[main_input]", "<Nop>")
vim.keymap.set({ "i", "c", "t", "s" }, "j<Space>", "[main_input]", { remap = true })

vim.keymap.set({ "i", "c", "t", "s" }, "[main_input]a", "-")
vim.keymap.set({ "i", "c", "t", "s" }, "[main_input]e", "=")
vim.keymap.set({ "i", "c", "t", "s" }, "[main_input]s", "_")
vim.keymap.set({ "i", "c", "t", "s" }, "[main_input]r", "<Bar>")
vim.keymap.set({ "i", "c", "t", "s" }, "[main_input]g", "\\")
vim.keymap.set({ "i", "c" }, "[main_input]h", "<C-r>+")
vim.keymap.set({ "t" }, "[main_input]h", "<Cmd>put +<CR>")
vim.keymap.set("s", "[main_input]h", [[<ESC>gv"_c<C-r>+]])
vim.keymap.set({ "i", "c", "t" }, "[main_input]v", "<C-q>")
vim.keymap.set({ "i", "c", "t", "s" }, "[main_input]c", "::")
vim.keymap.set({ "i", "c", "t", "s" }, "[main_input]fe", ":=")
vim.keymap.set({ "t" }, "[main_input]fq", "<C-c>")
vim.keymap.set({ "t" }, "[main_input]o", "<Tab>")
vim.keymap.set({ "i" }, "[main_input]<CR>", function()
  return require("notomo.lib.edit").to_multiline()
end, { expr = true })
vim.keymap.set("i", "[main_input]<Space>", [[<ESC>gUiwea]])
vim.keymap.set("i", "[main_input]z", [[<C-a>]])
vim.keymap.set("c", "[main_input]o", [[<C-n>]])

local with_undo = function(rhs)
  return vim.fn.substitute(rhs, "\\ze<Left>$", "\\<C-g>U", "")
end

vim.keymap.set({ "i", "s" }, "[main_input]w", with_undo('""<Left>'))
vim.keymap.set({ "c", "t" }, "[main_input]w", '""<Left>')

vim.keymap.set({ "i", "s" }, "[main_input]b", with_undo("``<Left>"))
vim.keymap.set({ "c", "t" }, "[main_input]b", "``<Left>")

vim.keymap.set({ "i", "s" }, "[main_input]l", with_undo("[]<Left>"))
vim.keymap.set({ "c", "t" }, "[main_input]l", "[]<Left>")

vim.keymap.set({ "i", "s" }, "[main_input]L", with_undo("[[]]<Left><Left>"))
vim.keymap.set({ "c", "t" }, "[main_input]L", "[[]]<Left><Left>")

vim.keymap.set({ "i", "s" }, "[main_input]t", with_undo("<><Left>"))
vim.keymap.set({ "c", "t" }, "[main_input]t", "<><Left>")

vim.keymap.set({ "i", "s" }, "[main_input]p", with_undo("()<Left>"))
vim.keymap.set({ "c", "t" }, "[main_input]p", "()<Left>")

vim.keymap.set({ "i", "s" }, "[main_input]d", with_undo("{}<Left>"))
vim.keymap.set({ "c", "t" }, "[main_input]d", "{}<Left>")

vim.keymap.set({ "i", "s" }, "[main_input]q", with_undo("''<Left>"))
vim.keymap.set({ "c", "t" }, "[main_input]q", "''<Left>")

vim.keymap.set({ "i", "s" }, "[main_input],", with_undo("<div></div><Left><Left><Left><Left><Left><Left>"))
vim.keymap.set({ "c", "t" }, "[main_input],", "<div></div><Left><Left><Left><Left><Left><Left>")

local complete_pairs = {
  { "(", ")" },
  { "{", "}" },
  { "[", "]" },
  { "<", ">" },
}
vim.keymap.set("i", "[main_input]k", function()
  local chars = vim.fn.strcharpart(vim.fn.getline("."), vim.fn.col(".") - 2, 2)
  for _, pair in ipairs(complete_pairs) do
    local l, r = unpack(pair)
    if chars == l then
      return r .. "<C-g>U<Left>"
    end
  end
  return "<Right>"
end, { expr = true })

vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]", "<Nop>")
vim.keymap.set({ "i", "c", "t", "s" }, "jk", "[sub_input]", { remap = true })

vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]a", "&")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]h", "^")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]p", "+")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]s", "#")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]r", "%")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]m", "@")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]t", "~")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]d", "$")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]e", "!")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]b", "`")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]c", ":")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]x", "*")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]q", "?")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input];", '"')
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input],", "'")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]g", "=>")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]f", "->")
vim.keymap.set({ "i", "c", "t", "s" }, "[sub_input]z", "<-")
vim.keymap.set({ "i", "c" }, "[sub_input]<CR>", "<C-r>=")

vim.keymap.set({ "n", "x" }, "[diff]j", [[]c]])
vim.keymap.set({ "n", "x" }, "[diff]k", [[[c]])
vim.keymap.set("n", "[diff]g", [[<Cmd>diffget<CR>]])
vim.keymap.set("n", "[diff]p", [[<Cmd>diffput<CR>]])
vim.keymap.set("n", "[diff]q", [[<Cmd>diffoff!<CR>]])
vim.keymap.set("x", "[diff]g", [[:diffget<CR>]])
vim.keymap.set("x", "[diff]p", [[:diffput<CR>]])

vim.keymap.set("n", "[arith]j", function()
  return require("notomo.lib.edit").inc_or_dec(false)
end, { expr = true })
vim.keymap.set("n", "[arith]k", function()
  return require("notomo.lib.edit").inc_or_dec(true)
end, { expr = true })
vim.keymap.set("x", "[arith]j", [[<C-x>gv]])
vim.keymap.set("x", "[arith]k", [[<C-a>gv]])
vim.keymap.set("x", "[arith]d", [[g<C-x>gv]])
vim.keymap.set("x", "[arith]u", [[g<C-a>gv]])
vim.keymap.set("n", "[exec]n", function()
  vim.cmd.nohlsearch()
  vim.lsp.buf.clear_references()
end)
vim.keymap.set("n", "[exec]l", [[':' .. getline('.') .. '<CR>']], { expr = true })
vim.keymap.set("n", "[exec]q", [[<Cmd>lua require("notomo.lib.edit").jq()<CR>]])
vim.keymap.set("n", "[exec]N", [[<Cmd>lua require("notomo.lib.edit").note()<CR>]])
vim.keymap.set("n", "[exec]O", [[<Cmd>lua require("notomo.lib.github").view_repo()<CR>]])
vim.keymap.set("n", "[exec]P", [[<Cmd>lua require("notomo.lib.github").view_pr()<CR>]])

vim.keymap.set("n", "[winmv]a", [[<C-w>h]])
vim.keymap.set("n", "[winmv]x", [[<C-w>j]])
vim.keymap.set("n", "[winmv]w", [[<C-w>k]])
vim.keymap.set("n", "[winmv]l", [[<C-w>l]])
vim.keymap.set("n", "[winmv]s", [[<C-w>r]])
vim.keymap.set("n", "[winmv];", [[<C-w>w]])

-- macro
vim.keymap.set("n", "mr", "qa")
vim.keymap.set("n", "mq", "q")
vim.keymap.set("n", "me", "@a")

vim.keymap.set("n", "[win]h", [[<Cmd>split<CR>]])
vim.keymap.set("n", "[win]v", [[<Cmd>vsplit<CR>]])
vim.keymap.set("n", "[win]o", [[<Cmd>silent only<CR>]])
vim.keymap.set("n", "[win]O", [[<Cmd>fclose!<CR>]])
vim.keymap.set("n", "[win]q", [[<Cmd>q<CR>]])
vim.keymap.set("n", "[win]e", [[<C-w>=]])

vim.keymap.set("n", "[tab]o", [[<Cmd>silent tabonly<CR>]], { silent = true })
vim.keymap.set("x", "[tab]o", [[<Esc><Cmd>silent tabonly<CR>]], { silent = true })
vim.keymap.set("n", "[tab]t", [[<Plug>(new_tab)]], { remap = true })
vim.keymap.set("n", "<C-Tab>", [[gt]])
vim.keymap.set("n", "<C-S-Tab>", [[gT]])
vim.keymap.set("i", "<C-Tab>", [[<Esc>gt]])
vim.keymap.set("i", "<C-S-Tab>", [[<Esc>gT]])
vim.keymap.set("v", "<C-Tab>", [[<Esc>gt]])
vim.keymap.set("v", "<C-S-Tab>", [[<Esc>gT]])
vim.keymap.set("n", "<C-w>", [[<Plug>(tabclose_c)]], { silent = true, nowait = true })
vim.keymap.set("i", "<C-w>", [[<ESC><Plug>(tabclose_c)]], { silent = true, remap = true })
vim.keymap.set("v", "<C-w>", [[<ESC><Plug>(tabclose_c)]], { silent = true, remap = true })
vim.keymap.set("n", "<C-t>", [[<Plug>(new_tab)]], { silent = true })
vim.keymap.set("t", "jj", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-j>", [[<Nop>]])
vim.keymap.set("t", "<C-p>", [[<Up>]])
vim.keymap.set("t", "<C-n>", [[<Down>]])
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = vim.api.nvim_create_augroup("notomo.terminal.mapping", {}),
  pattern = { "*" },
  callback = function()
    local path = vim.api.nvim_buf_get_name(0)
    if not vim.endswith(path, vim.o.shell) then
      return
    end
    vim.keymap.set("n", "[file]rl", function()
      vim.api.nvim_exec_autocmds("BufRead", { buffer = 0, modeline = false })
      vim.api.nvim_exec_autocmds("TermOpen", { modeline = false })
      vim.bo.filetype = ""
    end, { buffer = true })

    vim.keymap.set("n", "I", function()
      require("notomo.lib.prompt").open()
    end, { buffer = true })

    local enter = function()
      local ok, err = pcall(function()
        require("notomo.lib.edit").set_term_title()
      end)
      if not ok then
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.notify(err, vim.log.levels.WARN)
      end
      return "<CR>"
    end
    vim.keymap.set("t", "<CR>", enter, { expr = true, buffer = true })
    vim.keymap.set("t", "<C-CR>", enter, { expr = true, buffer = true })
    vim.keymap.set("t", "<S-CR>", enter, { expr = true, buffer = true })

    vim.keymap.set("n", "[finder]o", function()
      require("thetto.util.source").start_by_name("vim/terminal_prompt")
    end, { buffer = true })

    vim.keymap.set({ "n", "x" }, "sgj", function()
      require("thetto.util.source").go_to_next("vim/terminal_prompt")
    end, { buffer = true })
    vim.keymap.set("o", "gj", function()
      require("thetto.util.source").go_to_next("vim/terminal_prompt", { fields = { opts = { row_offset = 0 } } })
    end, { buffer = true })

    vim.keymap.set({ "n", "x" }, "sgk", function()
      require("thetto.util.source").go_to_previous("vim/terminal_prompt")
    end, { buffer = true })
    vim.keymap.set("o", "gk", function()
      require("thetto.util.source").go_to_previous("vim/terminal_prompt", { fields = { opts = { row_offset = 1 } } })
    end, { buffer = true })
  end,
})

if vim.fn.has("win32") == 1 then
  vim.keymap.set("t", "<C-u>", [[<C-Home>]])
end

vim.keymap.set("n", "[term]o", [[<Cmd>terminal<CR>]], { silent = true })
vim.keymap.set("n", "[term]v", [[<Cmd>vsplit|terminal<CR>]], { silent = true })
vim.keymap.set("n", "[term]h", [[<Cmd>split|terminal<CR>]], { silent = true })
vim.keymap.set("n", "[term]t", [[<Cmd>tabedit|terminal<CR>]], { silent = true })
vim.keymap.set("n", "[term]g", function()
  local git_root = require("notomo.lib.git").root() or "."
  vim.cmd.tabedit()
  vim.fn.jobstart(vim.opt.shell:get(), { cwd = git_root, term = true })
end, { silent = true })
vim.keymap.set(
  "n",
  "[yank]ud",
  [[<Cmd>lua require("notomo.lib.edit").yank(require("misclib.url").decode(vim.fn.expand('<cWORD>')))<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[yank]ue",
  [[<Cmd>lua require("notomo.lib.edit").yank(require("misclib.url").encode(vim.fn.expand('<cWORD>')))<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[yank]M",
  [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.trim(vim.fn.system('mongosh --norc --nodb --quiet --eval "(new ObjectId()).toString()"')))<CR>]]
)
vim.keymap.set("n", "[term]S", [[<Cmd>lua require("notomo.plugin.termdebug").start()<CR>]])
vim.keymap.set("n", "[term]q", [[<Cmd>lua require("notomo.plugin.termdebug").quit()<CR>]])

vim.keymap.set("n", "[git]H", function()
  return require("notomo.lib.git").pull({ "--autostash" })
end, { expr = true })
vim.keymap.set("n", "[git]F", function()
  return require("notomo.lib.git").fetch()
end, { expr = true })
vim.keymap.set("n", "[git]P", function()
  return require("notomo.lib.git").push()
end, { expr = true })
vim.keymap.set("n", "[git]ma", function()
  return require("notomo.lib.git").cmd({ "merge", "--abort" })
end, { expr = true })
vim.keymap.set("n", "[git]ca", function()
  return require("notomo.lib.git").cmd({ "cherry-pick", "--abort" })
end, { expr = true })
vim.keymap.set("n", "[git]ra", function()
  return require("notomo.lib.git").cmd({ "rebase", "--abort" })
end, { expr = true })
vim.keymap.set("n", "[git]A", function()
  return require("notomo.lib.git").apply()
end, { expr = true })
vim.keymap.set({ "n", "x" }, "[yank]U", function()
  require("notomo.lib.github").yank()
end)

vim.keymap.set({ "n", "x" }, "[browser]", "<Nop>")
vim.keymap.set({ "n", "x" }, "[exec]b", "[browser]", { remap = true })

vim.keymap.set("n", "[browser]o", function()
  require("notomo.lib.browser").open(vim.fn.expand("<cWORD>"))
end)
vim.keymap.set("n", "[browser]y", function()
  require("notomo.lib.browser").open(vim.fn.getreg("+"))
end)

vim.api.nvim_create_user_command("SearchEngine", function(command)
  local query = command.fargs[1]
  local url = [[https://google.com/search?q=]] .. require("misclib.url").encode(query)
  vim.notify("Open: " .. url)
  require("notomo.lib.browser").open(url)
end, { nargs = 1 })
vim.keymap.set("n", "[browser]i", [[:<C-u>SearchEngine ]])
vim.keymap.set("n", "[browser]s", [[:<C-u>SearchEngine <C-r>=expand('<cword>')<CR><CR>]])

vim.keymap.set("x", "t<Space>", function()
  require("notomo.lib.edit").open_selected()
end)
vim.keymap.set("x", "<Leader>A", function()
  vim.ui.input({
    prompt = "Separator:",
  }, function(separator)
    if not separator then
      require("notomo.lib.message").info("Canceled.")
      return
    end
    require("notomo.lib.edit").align(separator)
  end)
end)

vim.keymap.set("n", "<Space>R", "<Cmd>restart<CR>")

vim.keymap.set("n", "[exec]v", function()
  require("notomo.plugin.aliaser").open_in_vscode()
end)
