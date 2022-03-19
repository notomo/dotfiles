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

vim.fn["gina#custom#command#option"]("show", "--group", "show")
vim.fn["gina#custom#command#option"]("changes", "--group", "changes")
vim.fn["gina#custom#command#option"]("status", "--group", "short")
vim.fn["gina#custom#command#option"]("commit", "--group", "short")

vim.fn["gina#custom#command#option"]([[/\%(status\|changes\|ls\|commit\)]], "--opener", "botright split")
vim.fn["gina#custom#command#option"]([[/\%(diff\|blame\|compare\|patch\|log\)]], "--opener", "tabedit")

vim.g["gina#core#console#enable_message_history"] = 1

vim.api.nvim_create_augroup("gina_setting", {})

vim.g["gina#command#status#use_default_mappings"] = 0
vim.g["gina#action#index#discard_directories"] = 1
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-status" },
  callback = function()
    vim.keymap.set({ "n", "v" }, "[git]a", [[<Plug>(gina-index-toggle)]], { buffer = true, silent = true })
    vim.keymap.set({ "n", "v" }, "[git]u", [[<Plug>(gina-index-unstage)]], { buffer = true, silent = true })
    vim.keymap.set({ "n", "v" }, "U", [[<Plug>(gina-index-discard)]], { buffer = true, silent = true })

    vim.keymap.set({ "n" }, "cc", [[<Cmd>Gina commit<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "ca", [[<Cmd>Gina commit --amend<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "cs", [[:call gina#action#call('chaperon:tab')<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "pp", [[:call gina#action#call("patch:tab")<CR>]], { buffer = true, silent = true })
    vim.keymap.set(
      { "n", "v" },
      "S",
      [[:lua require("notomo.gina").stash_file()<CR>]],
      { buffer = true, silent = true }
    )

    vim.keymap.set("n", "o", function()
      require("notomo.gina").edit("edit")
    end, { buffer = true, silent = true })
    vim.keymap.set("n", "t<Space>", function()
      require("notomo.gina").edit("edit:tab")
    end, { buffer = true, silent = true })
    vim.keymap.set("n", "<CR>", function()
      require("notomo.gina").edit("edit:tab")
    end, { buffer = true, silent = true })

    vim.keymap.set(
      { "n" },
      "j",
      [=[:lua require("notomo.edit").to_next_syntax([[\vAnsi+]], 10, 0)<CR>]=],
      { buffer = true, silent = true }
    )
    vim.keymap.set(
      { "n" },
      "k",
      [=[:lua require("notomo.edit").to_prev_syntax([[\vAnsi+]], 10, 0)<CR>]=],
      { buffer = true, silent = true }
    )
    vim.keymap.set(
      { "n" },
      "gg",
      [=[gg:lua require("notomo.edit").to_next_syntax([[\vAnsi+]], 10, 0)<CR>]=],
      { buffer = true, silent = true }
    )
    vim.keymap.set(
      { "n" },
      "G",
      [=[G:lua require("notomo.edit").to_prev_syntax([[\vAnsi+]], 10, 0)<CR>]=],
      { buffer = true, silent = true }
    )

    vim.keymap.set({ "n" }, "dd", ':call gina#action#call("patch:oneside:tab")<CR>', { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "q", ":quit<CR>", { buffer = true, silent = true })
  end,
})

vim.fn["gina#custom#command#option"]("branch", "-v", "v")
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-branch" },
  callback = function()
    vim.keymap.set({ "n" }, "rn", [[<Plug>(gina-branch-move)]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "rf", [[<Plug>(gina-branch-reflesh)]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "C", [[<Plug>(gina-branch-new)]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "MA", [[:call gina#action#call('commit:merge')<CR>]], { buffer = true, silent = true })

    vim.keymap.set(
      { "n" },
      "cp",
      [[:call gina#action#call("commit:cherry-pick")<CR>]],
      { buffer = true, silent = true }
    )
    vim.keymap.set({ "n" }, "yu", [[:lua require("notomo.gina").browse_yank()<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "yr", [[:lua require("notomo.gina").yank_rev()<CR>]], { buffer = true, silent = true })

    vim.keymap.set({ "n" }, "q", ":quit<CR>", { buffer = true, silent = true })
  end,
})

vim.g["gina#command#log#use_default_mappings"] = 0
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-log" },
  callback = function()
    vim.keymap.set(
      { "n" },
      "<CR>",
      [[:call gina#action#call('show:commit:right')<CR>]],
      { buffer = true, silent = true }
    )
    vim.keymap.set({ "n" }, "RS", [[<Plug>(gina-commit-reset)]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "ch", [[:call gina#action#call('commit:checkout')<CR>]], { buffer = true, silent = true })
    vim.keymap.set(
      { "n" },
      "T",
      [[:call gina#action#call('commit:tag:lightweight')<CR>]],
      { buffer = true, silent = true }
    )
    vim.keymap.set({ "n" }, "I", [[:lua require("notomo.gina").rebase_i()<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "F", [[:lua require("notomo.gina").fixup()<CR>]], { buffer = true, silent = true })
    vim.keymap.set(
      { "n" },
      "yR",
      [[:lua require("notomo.gina").yank_rev_with_repo()<CR>]],
      { buffer = true, silent = true }
    )

    vim.keymap.set(
      { "n" },
      "cp",
      [[:call gina#action#call("commit:cherry-pick")<CR>]],
      { buffer = true, silent = true }
    )
    vim.keymap.set({ "n" }, "yu", [[:lua require("notomo.gina").browse_yank()<CR>]], { buffer = true, silent = true })

    vim.keymap.set({ "n" }, "yr", [[:lua require("notomo.gina").yank_rev()<CR>]], { buffer = true, silent = true })
  end,
})

vim.fn["gina#custom#command#alias"]("stash", "stash_for_list")
vim.fn["gina#custom#command#option"]([[/\%(stash_for_list\|branch\)]], "--opener", "topleft split")
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-stash" },
  callback = function()
    vim.keymap.set({ "n", "v" }, "dr", [[<Plug>(gina-stash-drop)]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "AP", [[<Plug>(gina-stash-apply)]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "pop", "<Plug>(gina-stash-pop)", { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "o", ':call gina#action#call("stash:show")<CR>', { buffer = true, silent = true })
    vim.keymap.set(
      { "n" },
      "t<Space>",
      ':call gina#action#call("stash:show:tab")<CR>',
      { buffer = true, silent = true }
    )
    vim.keymap.set({ "n" }, "sv", ':call gina#action#call("stash:show:rightest")<CR>', { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "sh", ':call gina#action#call("stash:show:bottom")<CR>', { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "<CR>", ':call gina#action#call("stash:show:tab")<CR>', { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "q", ":quit<CR>", { buffer = true, silent = true })
  end,
})

vim.fn["gina#custom#command#option"]("branch", "-v", "v")
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-tag" },
  callback = function()
    vim.keymap.set({ "n" }, "DD", [[:call gina#action#call('tag:delete')<CR>]], { buffer = true, silent = true })
    vim.keymap.set(
      { "n" },
      "C",
      [[:call gina#action#call('tag:new:lightweight')<CR>]],
      { buffer = true, silent = true }
    )
    vim.keymap.set({ "n" }, "P", function()
      return require([[notomo.gina]]).push_cmd()
    end, { buffer = true, silent = true, expr = true })

    vim.keymap.set({ "n" }, "yr", [[:lua require("notomo.gina").yank_rev()<CR>]], { buffer = true, silent = true })
  end,
})

vim.g["gina#command#blame#formatter#format"] = "%su%=on %ti by %au %ma%in"
vim.g["gina#command#blame#formatter#timestamp_format1"] = "%Y-%m-%d"
vim.g["gina#command#blame#formatter#timestamp_format2"] = "%Y-%m-%d"
vim.g["gina#command#blame#formatter#timestamp_months"] = 0
vim.fn["gina#custom#command#option"]("blame", "--width", "90")
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-blame" },
  callback = function()
    vim.keymap.set({ "n" }, "j", "j<Plug>(gina-blame-echo)", { buffer = true })
    vim.keymap.set({ "n" }, "k", "k<Plug>(gina-blame-echo)", { buffer = true })
    vim.keymap.set({ "n" }, "<CR>", [[:call gina#action#call('show:commit:tab')<CR>]], { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-patch" },
  callback = function()
    vim.keymap.set({ "n", "x" }, "[diff]p", "<Plug>(gina-diffput)", { buffer = true, silent = true })
    vim.keymap.set({ "n", "x" }, "[diff]G", "<Plug>(gina-diffget)", { buffer = true, silent = true })
    vim.keymap.set({ "n", "x" }, "[diff]gl", "<Plug>(gina-diffget-r)", { buffer = true, silent = true })
    vim.keymap.set({ "n", "x" }, "[diff]ga", "<Plug>(gina-diffget-l)", { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-diff" },
  callback = function()
    vim.keymap.set("n", "sgj", function()
      require("notomo.edit").to_prev_syntax("diffLine", 1, 1)
    end, { buffer = true, silent = true })
    vim.keymap.set("n", "sgk", function()
      require("notomo.edit").to_prev_syntax("diffLine", 1, -1)
    end, { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-commit" },
  callback = function()
    vim.keymap.set({ "n" }, "[file]w", ":wq<CR>", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-log", "gina-blame", "gina-branch", "gina-tag" },
  callback = function()
    vim.keymap.set(
      { "n" },
      "cc",
      [[:call gina#action#call("changes:of:rightest")<CR>]],
      { buffer = true, silent = true }
    )
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-log", "gina-stash", "gina-blame", "gina-compare" },
  callback = function()
    vim.keymap.set({ "n" }, "dd", [[:call gina#action#call("compare")<CR>]], { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-status", "gina-log", "gina-stash", "gina-blame", "gina-compare" },
  callback = function()
    vim.keymap.set({ "n" }, "D", [[:call gina#action#call("diff")<CR>]], { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-log", "gina-ls", "gina-blame", "gina-changes", "gina-tag", "gina-branch" },
  callback = function()
    vim.keymap.set({ "n" }, "o", [[:call gina#action#call("show")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "t<Space>", [[:call gina#action#call("show:tab")<CR>]], { buffer = true, silent = true })
    vim.keymap.set({ "n" }, "sv", [[:call gina#action#call("show:rightest")<CR>]], { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gina_setting",
  pattern = { "gina-ls", "gina-blame", "gina-changes", "gina-tag", "gina-status" },
  callback = function()
    vim.keymap.set({ "n" }, "<CR>", [[:call gina#action#call("show:tab")<CR>]], { buffer = true, silent = true })
  end,
})

-- HACK
vim.fn["gina#component#repo#branch"]()
