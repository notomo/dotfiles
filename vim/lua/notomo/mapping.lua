local M = {}

local TAB_MODE = "tab"
local TAB_KEY = ("[%s]"):format(TAB_MODE)
local tab_input = {
  {lhs = "l", rhs = "<Esc>gt", map_only = false, remap = false},
  {lhs = "s", rhs = "<Cmd>tabr<CR>", map_only = false, remap = false},
  {lhs = "e", rhs = "<Cmd>tabl<CR>", map_only = false, remap = false},
  {lhs = "a", rhs = "<Esc>gT", map_only = false, remap = false},
  {lhs = "h", rhs = "<Esc>gT", map_only = false, remap = false},
  {lhs = "q", rhs = "<Esc><Plug>(tabclose_c)", map_only = false, remap = true},
  {lhs = "da", rhs = "<Esc><Plug>(tabclose_l)", map_only = true, remap = true},
  {lhs = "dl", rhs = "<Esc><Plug>(tabclose_r)", map_only = true, remap = true},
  {lhs = "d;", rhs = "<Cmd>+tabclose<CR>", map_only = false, remap = false},
  {lhs = "ml", rhs = "<Cmd>tabm+1<CR>", map_only = false, remap = false},
  {lhs = "ms", rhs = "<Cmd>tabm 0<CR>", map_only = false, remap = false},
  {lhs = "me", rhs = "<Cmd>tabm<CR>", map_only = false, remap = false},
  {lhs = "ma", rhs = "<Cmd>tabm-1<CR>", map_only = false, remap = false},
}
function M.set_tab()
  for _, m in ipairs(tab_input) do
    vim.cmd(([[nnoremap [tab]%s <Cmd>lua require("notomo.mapping").setup_tab_submode(%q)<CR>]]):format(m.lhs, m.lhs))
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
      M._set_one("nmap", TAB_KEY .. m.lhs, m.rhs)
      M._set_one("xmap", TAB_KEY .. m.lhs, m.rhs)
    else
      M._set_one("nnoremap", TAB_KEY .. m.lhs, m.rhs)
      M._set_one("xnoremap", TAB_KEY .. m.lhs, m.rhs)
    end
  else
    vim.fn["submode#enter_with"](TAB_MODE, "nx", remap, TAB_KEY .. m.lhs, m.rhs)
  end
  vim.fn["submode#map"](TAB_MODE, "n", remap, m.lhs, m.rhs)
end

local MAIN_INPUT_PFX = "j<Space>"
local main_input = {
  {lhs = MAIN_INPUT_PFX .. "a", rhs = "-"},
  {lhs = MAIN_INPUT_PFX .. "e", rhs = "="},
  {lhs = MAIN_INPUT_PFX .. "s", rhs = "_"},
  {lhs = MAIN_INPUT_PFX .. "r", rhs = "<Bar>"},
  {lhs = MAIN_INPUT_PFX .. "g", rhs = "\\"},
  {lhs = MAIN_INPUT_PFX .. "w", rhs = "\"\"<Left>"},
  {lhs = MAIN_INPUT_PFX .. "b", rhs = "``<Left>"},
  {lhs = MAIN_INPUT_PFX .. "l", rhs = "[]<Left>"},
  {lhs = MAIN_INPUT_PFX .. "t", rhs = "<><Left>"},
  {lhs = MAIN_INPUT_PFX .. "p", rhs = "()<Left>"},
  {lhs = MAIN_INPUT_PFX .. "d", rhs = "{}<Left>"},
  {lhs = MAIN_INPUT_PFX .. "q", rhs = "''<Left>"},
  {lhs = MAIN_INPUT_PFX .. "h", rhs = "<C-r>+"},
  {lhs = MAIN_INPUT_PFX .. "v", rhs = "<C-q>"},
  {lhs = MAIN_INPUT_PFX .. "c", rhs = "::"},
  {lhs = MAIN_INPUT_PFX .. "fe", rhs = ":="},
  {lhs = MAIN_INPUT_PFX .. "fq", rhs = "<C-c>"},
  {lhs = MAIN_INPUT_PFX .. "fp", rhs = "<Up><CR>"},
  {lhs = MAIN_INPUT_PFX .. "m", rhs = "<CR>"},
}
function M.set_main_input()
  M._set_with_undo(main_input)
  M._set("cnoremap", main_input)
  M._set("tnoremap", main_input)
  M._set_one("tnoremap", MAIN_INPUT_PFX .. "h", "<Cmd>put +<CR>")
  M._set_one("tnoremap", MAIN_INPUT_PFX .. "o", "<Tab>")
  M._set_one("inoremap <expr>", MAIN_INPUT_PFX .. "<CR>", "notomo#vimrc#to_multiline()")
end

local SUB_INPUT_PFX = "jk"
local sub_input = {
  {lhs = SUB_INPUT_PFX .. "a", rhs = "&"},
  {lhs = SUB_INPUT_PFX .. "h", rhs = "^"},
  {lhs = SUB_INPUT_PFX .. "p", rhs = "+"},
  {lhs = SUB_INPUT_PFX .. "s", rhs = "#"},
  {lhs = SUB_INPUT_PFX .. "r", rhs = "%"},
  {lhs = SUB_INPUT_PFX .. "m", rhs = "@"},
  {lhs = SUB_INPUT_PFX .. "t", rhs = "~"},
  {lhs = SUB_INPUT_PFX .. "d", rhs = "$"},
  {lhs = SUB_INPUT_PFX .. "e", rhs = "!"},
  {lhs = SUB_INPUT_PFX .. "b", rhs = "`"},
  {lhs = SUB_INPUT_PFX .. "c", rhs = ":"},
  {lhs = SUB_INPUT_PFX .. "x", rhs = "*"},
  {lhs = SUB_INPUT_PFX .. "q", rhs = "?"},
  {lhs = SUB_INPUT_PFX .. ";", rhs = "\""},
  {lhs = SUB_INPUT_PFX .. ",", rhs = "'"},
  {lhs = SUB_INPUT_PFX .. "g", rhs = "=>"},
  {lhs = SUB_INPUT_PFX .. "f", rhs = "->"},
  {lhs = SUB_INPUT_PFX .. "z", rhs = "<-"},
  {lhs = SUB_INPUT_PFX .. "v", rhs = "<%=  %><Left><Left><Left>"},
}
function M.set_sub_input()
  M._set_with_undo(sub_input)
  M._set("cnoremap", sub_input)
  M._set("tnoremap", sub_input)
  M._set_one("noremap!", SUB_INPUT_PFX .. "<CR>", "<C-r>=")
end

function M._set(cmd, mappings)
  for _, m in ipairs(mappings) do
    M._set_one(cmd, m.lhs, m.rhs)
  end
end

function M._set_with_undo(mappings)
  for _, m in ipairs(mappings) do
    M._set_one("inoremap", m.lhs, vim.fn.substitute(m.rhs, "\\ze<Left>$", "\\<C-g>U", ""))
  end
end

function M._set_one(cmd, lhs, rhs)
  vim.cmd(("%s %s %s"):format(cmd, lhs, rhs))
end

function M.lsp()
  vim.cmd([[
nnoremap <buffer> [keyword]o <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer> [keyword]v <Cmd>vsplit \| lua vim.lsp.buf.definition()<CR>
nnoremap <buffer> [keyword]h <Cmd>split \| lua vim.lsp.buf.definition()<CR>
nnoremap <buffer> [keyword]t <Cmd>lua require("wintablib.window").duplicate_as_right_tab()<CR>:lua vim.lsp.buf.definition()<CR>
]])
end

return M
