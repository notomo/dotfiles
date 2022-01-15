local M = {}

local TAB_MODE = "tab"
local TAB_KEY = ("[%s]"):format(TAB_MODE)
local tab_input = {
  { lhs = "l", rhs = "<Esc>gt", map_only = false, remap = false },
  { lhs = "s", rhs = "<Cmd>tabr<CR>", map_only = false, remap = false },
  { lhs = "e", rhs = "<Cmd>tabl<CR>", map_only = false, remap = false },
  { lhs = "a", rhs = "<Esc>gT", map_only = false, remap = false },
  { lhs = "h", rhs = "<Esc>gT", map_only = false, remap = false },
  { lhs = "q", rhs = "<Esc><Plug>(tabclose_c)", map_only = false, remap = true },
  { lhs = "da", rhs = "<Esc><Plug>(tabclose_l)", map_only = true, remap = true },
  { lhs = "dl", rhs = "<Esc><Plug>(tabclose_r)", map_only = true, remap = true },
  { lhs = "d;", rhs = "<Cmd>+tabclose<CR>", map_only = false, remap = false },
  { lhs = "ml", rhs = "<Cmd>tabm+1<CR>", map_only = false, remap = false },
  { lhs = "ms", rhs = "<Cmd>tabm 0<CR>", map_only = false, remap = false },
  { lhs = "me", rhs = "<Cmd>tabm<CR>", map_only = false, remap = false },
  { lhs = "ma", rhs = "<Cmd>tabm-1<CR>", map_only = false, remap = false },
}
function M.set_tab()
  for _, m in ipairs(tab_input) do
    vim.keymap.set("n", "[tab]" .. m.lhs, function()
      return require("notomo.mapping").setup_tab_submode(m.lhs)
    end)
  end
end

function M.setup_tab_submode(enter_key)
  for _, m in ipairs(tab_input) do
    M._tab(m)
  end
  vim.fn["submode#leave_with"](TAB_MODE, "n", "", "j")
  vim.fn.feedkeys(TAB_KEY .. enter_key)
end

function M._tab(m)
  local remap = ""
  if m.remap then
    remap = "r"
  end
  if m.map_only then
    if m.remap then
      vim.keymap.set({ "n", "x" }, TAB_KEY .. m.lhs, m.rhs, { remap = true })
    else
      vim.keymap.set({ "n", "x" }, TAB_KEY .. m.lhs, m.rhs)
    end
  else
    vim.fn["submode#enter_with"](TAB_MODE, "nx", remap, TAB_KEY .. m.lhs, m.rhs)
  end
  vim.fn["submode#map"](TAB_MODE, "n", remap, m.lhs, m.rhs)
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
function M.set_main_input()
  M._set_with_undo(main_input)
  for _, m in ipairs(main_input) do
    vim.keymap.set({ "c", "t" }, m.lhs, m.rhs)
  end
  vim.keymap.set("t", MAIN_INPUT_PFX .. "h", "<Cmd>put +<CR>")
  vim.keymap.set("t", MAIN_INPUT_PFX .. "o", "<Tab>")
  vim.keymap.set("i", MAIN_INPUT_PFX .. "<CR>", function()
    return require("notomo.edit").to_multiline()
  end, { expr = true })
end

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
function M.set_sub_input()
  M._set_with_undo(sub_input)
  for _, m in ipairs(sub_input) do
    vim.keymap.set({ "c", "t" }, m.lhs, m.rhs)
  end
  vim.keymap.set({ "i", "c" }, SUB_INPUT_PFX .. "<CR>", "<C-r>=")
end

function M._set_with_undo(mappings)
  for _, m in ipairs(mappings) do
    vim.keymap.set("i", m.lhs, vim.fn.substitute(m.rhs, "\\ze<Left>$", "\\<C-g>U", ""))
  end
end

function M.lsp()
  vim.keymap.set("n", "[keyword]o", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]v", [[<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]h", [[<Cmd>split | lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]t", function()
    require("wintablib.window").duplicate_as_right_tab()
    vim.lsp.buf.definition()
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
  vim.keymap.set("n", "<expr>[git]A", function()
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
