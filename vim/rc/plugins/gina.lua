local silent = { silent = 1 }
local noremap_silent = { noremap = 1, silent = 1 }

for _, mode_char in ipairs({ "n", "v" }) do
  local mode_silent = { mode = mode_char, silent = 1 }

  -- status
  vim.fn["gina#custom#mapping#map"]("status", "[git]a", "<Plug>(gina-index-toggle)", mode_silent)
  vim.fn["gina#custom#mapping#map"]("status", "[git]u", "<Plug>(gina-index-unstage)", mode_silent)
  vim.fn["gina#custom#mapping#map"]("status", "U", "<Plug>(gina-index-discard)", mode_silent)

  -- stash
  vim.fn["gina#custom#mapping#map"]("stash", "dr", "<Plug>(gina-stash-drop)", mode_silent)

  -- patch
  vim.fn["gina#custom#mapping#map"]("patch", "[diff]p", "<Plug>(gina-diffput)", mode_silent)
  vim.fn["gina#custom#mapping#map"]("patch", "[diff]G", "<Plug>(gina-diffget)", mode_silent)
  vim.fn["gina#custom#mapping#map"]("patch", "[diff]gl", "<Plug>(gina-diffget-r)", mode_silent)
  vim.fn["gina#custom#mapping#map"]("patch", "[diff]ga", "<Plug>(gina-diffget-l)", mode_silent)

  -- mark
  vim.fn["gina#custom#mapping#map"]([[/\%(status\|stash\|branch\)]], "sm", "<Plug>(gina-builtin-mark)", mode_silent)
  vim.fn["gina#custom#mapping#map"](
    [[/\%(status\|stash\|branch\)]],
    "su",
    "<Plug>(gina-builtin-mark-unset)",
    mode_silent
  )
end

vim.g["gina#command#blame#use_default_aliases"] = 0
vim.g["gina#command#branch#use_default_aliases"] = 0
vim.g["gina#command#changes#use_default_aliases"] = 0
vim.g["gina#command#grep#use_default_aliases"] = 0
vim.g["gina#command#log#use_default_aliases"] = 0
vim.g["gina#command#ls#use_default_aliases"] = 0
vim.g["gina#command#reflog#use_default_aliases"] = 0
vim.g["gina#command#stash#use_default_aliases"] = 0
vim.g["gina#command#stash#show#use_default_aliases"] = 0
vim.g["gina#command#status#use_default_aliases"] = 0
vim.g["gina#command#tag#use_default_aliases"] = 0

-- status
vim.g["gina#command#status#use_default_mappings"] = 0
vim.g["gina#action#index#discard_directories"] = 1
vim.fn["gina#custom#mapping#nmap"]("status", "cc", "<Cmd>Gina commit<CR>", noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("status", "ca", "<Cmd>Gina commit --amend<CR>", noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("status", "cs", [[:call gina#action#call('chaperon:tab')<CR>]], noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("status", "pp", ':call gina#action#call("patch:tab")<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("status", "S", ':lua require("notomo.gina").stash_file()<CR>', noremap_silent)

-- stash
vim.fn["gina#custom#mapping#nmap"]("stash", "AP", "<Plug>(gina-stash-apply)", silent)
vim.fn["gina#custom#mapping#nmap"]("stash", "pop", "<Plug>(gina-stash-pop)", silent)
vim.fn["gina#custom#mapping#nmap"]("stash", "o", ':call gina#action#call("stash:show")<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("stash", "t<Space>", ':call gina#action#call("stash:show:tab")<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("stash", "sv", ':call gina#action#call("stash:show:rightest")<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("stash", "sh", ':call gina#action#call("stash:show:bottom")<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("stash", "<CR>", ':call gina#action#call("stash:show:tab")<CR>', noremap_silent)

-- branch
vim.fn["gina#custom#mapping#nmap"]("branch", "rn", "<Plug>(gina-branch-move)", silent)
-- vim.fn["gina#custom#mapping#nmap"]('branch', 'dl', '<Plug>(gina-branch-delete)', silent)
vim.fn["gina#custom#mapping#nmap"]("branch", "rf", "<Plug>(gina-branch-reflesh)", silent)
vim.fn["gina#custom#mapping#nmap"]("branch", "C", "<Plug>(gina-branch-new)", silent)
vim.fn["gina#custom#command#option"]("branch", "-v", "v")
vim.fn["gina#custom#mapping#nmap"]("branch", "MA", [[:call gina#action#call('commit:merge')<CR>]], noremap_silent)

-- group
vim.fn["gina#custom#command#option"]("show", "--group", "show")
vim.fn["gina#custom#command#option"]("changes", "--group", "changes")
vim.fn["gina#custom#command#option"]("status", "--group", "short")
vim.fn["gina#custom#command#option"]("commit", "--group", "short")

-- opener
vim.fn["gina#custom#command#option"]([[/\%(status\|changes\|ls\|commit\)]], "--opener", "botright split")
vim.fn["gina#custom#command#alias"]("stash", "stash_for_list")
vim.fn["gina#custom#command#option"]([[/\%(stash_for_list\|branch\)]], "--opener", "topleft split")
vim.fn["gina#custom#command#option"]([[/\%(diff\|blame\|compare\|patch\|log\)]], "--opener", "tabedit")

-- open
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\|ls\|blame\|changes\|tag\|branch\)]],
  "o",
  ':call gina#action#call("show")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\|ls\|blame\|changes\|tag\|branch\)]],
  "t<Space>",
  ':call gina#action#call("show:tab")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\|ls\|blame\|changes\|tag\|branch\)]],
  "sv",
  ':call gina#action#call("show:rightest")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\|ls\|blame\|changes\|tag\|branch\)]],
  "sh",
  ':call gina#action#call("show:bottom")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(ls\|blame\|changes\|status\|tag\)]],
  "<CR>",
  ':call gina#action#call("show:tab")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"]("status", "o", ':lua require("notomo.gina").edit("edit")<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"](
  "status",
  "t<Space>",
  ':lua require("notomo.gina").edit("edit:tab")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"]("status", "<CR>", ':lua require("notomo.gina").edit("edit:tab")<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"]([[/\%(status\|stash\|branch\)]], "q", ":quit<CR>", noremap_silent)

-- yank
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\|branch\|blame\)]],
  "yr",
  ':lua require("notomo.gina").yank_rev()<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\)]],
  "yR",
  ':lua require("notomo.gina").yank_rev_with_repo()<CR>',
  noremap_silent
)

-- show changes, compare
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\|blame\|branch\|tag\)]],
  "cb",
  ':call gina#action#call("changes:between:rightest")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\|blame\|branch\|tag\)]],
  "cf",
  ':call gina#action#call("changes:from:rightest")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(log\|blame\|branch\|tag\)]],
  "cc",
  ':call gina#action#call("changes:of:rightest")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"]("status", "dd", ':call gina#action#call("patch:oneside:tab")<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(blame\|stash\|log\|compare\)]],
  "dd",
  ':call gina#action#call("compare")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(status\|blame\|stash\|log\|compare\)]],
  "D",
  ':call gina#action#call("diff")<CR>',
  noremap_silent
)

-- commit
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(branch\|log\)]],
  "cp",
  ':call gina#action#call("commit:cherry-pick")<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(branch\|log\)]],
  "yu",
  ':lua require("notomo.gina").browse_yank()<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"]("commit", "[file]w", ":wq<CR>", { noremap = 1 })

-- blame
vim.g["gina#command#blame#formatter#format"] = "%su%=on %ti by %au %ma%in"
vim.g["gina#command#blame#formatter#timestamp_format1"] = "%Y-%m-%d"
vim.g["gina#command#blame#formatter#timestamp_format2"] = "%Y-%m-%d"
vim.g["gina#command#blame#formatter#timestamp_months"] = 0
vim.fn["gina#custom#command#option"]("blame", "--width", "90")
vim.fn["gina#custom#mapping#nmap"]("blame", "j", "j<Plug>(gina-blame-echo)")
vim.fn["gina#custom#mapping#nmap"]("blame", "k", "k<Plug>(gina-blame-echo)")
vim.fn["gina#custom#mapping#nmap"]("blame", "<CR>", [[:call gina#action#call('show:commit:tab')<CR>]], noremap_silent)

-- diff
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(diff\|commit\)]],
  "sgj",
  ':lua require("notomo.edit").to_next_syntax([[diffLine]], 1, 1)<CR>',
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  [[/\%(diff\|commit\)]],
  "sgk",
  ':lua require("notomo.edit").to_prev_syntax([[diffLine]], 1, -1)<CR>',
  noremap_silent
)

-- status
vim.fn["gina#custom#mapping#nmap"](
  "status",
  "j",
  [=[:lua require("notomo.edit").to_next_syntax([[\vAnsi+]], 10, 0)<CR>]=],
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  "status",
  "k",
  [=[:lua require("notomo.edit").to_prev_syntax([[\vAnsi+]], 10, 0)<CR>]=],
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  "status",
  "gg",
  [=[gg:lua require("notomo.edit").to_next_syntax([[\vAnsi+]], 10, 0)<CR>]=],
  noremap_silent
)
vim.fn["gina#custom#mapping#nmap"](
  "status",
  "G",
  [=[G:lua require("notomo.edit").to_prev_syntax([[\vAnsi+]], 10, 0)<CR>]=],
  noremap_silent
)

-- log
vim.g["gina#command#log#use_default_mappings"] = 0
vim.fn["gina#custom#mapping#nmap"]("log", "<CR>", [[:call gina#action#call('show:commit:right')<CR>]], noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("log", "RS", "<Plug>(gina-commit-reset)", silent)
vim.fn["gina#custom#mapping#nmap"]("log", "ch", [[:call gina#action#call('commit:checkout')<CR>]], noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("log", "T", [[:call gina#action#call('commit:tag:lightweight')<CR>]], noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("log", "I", ':lua require("notomo.gina").rebase_i()<CR>', noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("log", "F", ':lua require("notomo.gina").fixup()<CR>', noremap_silent)

-- tag
vim.fn["gina#custom#mapping#nmap"]("tag", "DD", [[:call gina#action#call('tag:delete')<CR>]], noremap_silent)
vim.fn["gina#custom#mapping#nmap"]("tag", "C", [[:call gina#action#call('tag:new:lightweight')<CR>]], noremap_silent)
vim.fn["gina#custom#mapping#nmap"](
  "tag",
  "P",
  'luaeval("require([[notomo.gina]]).push_cmd()")',
  { noremap = 1, expr = 1 }
)

vim.g["gina#core#console#enable_message_history"] = 1

-- HACK
vim.fn["gina#component#repo#branch"]()
