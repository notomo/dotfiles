require("lreload").enable("aliaser", {
  post_hook = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/aliaser.lua"))
  end,
})

local aliaser = require("aliaser")

aliaser.register_factory("thetto", function(aliases)
  aliases:set("assigned_issues", function()
    require("thetto").start("github/issue", { source_opts = { assignee = "me" } })
  end)
end)

aliaser.register_factory("vim", function(aliases)
  aliases:set("clear_messages", "messages clear")

  aliases:set("cmdline_window_for_excmd", function()
    vim.fn.feedkeys("q:", "n")
  end)
  aliases:set("cmdline_window_for_search", function()
    vim.fn.feedkeys("q/", "n")
  end)

  aliases:set("rename", function()
    vim.fn.feedkeys(":file ", "n")
  end)

  aliases:set("check_health", "checkhealth")
  aliases:set("reload_vimrc", function()
    if vim.env.MYVIMRC and vim.env.MYVIMRC ~= "" then
      vim.cmd("source " .. vim.env.MYVIMRC)
    end
    vim.cmd("nohlsearch")
  end)

  aliases:set("diff", function(...)
    require("notomo.diff").diff(...)
  end, { nargs_max = 2 })
end)

aliaser.register_factory("other", function(aliases)
  aliases:set("mkup_document_root", function()
    require("notomo.edit").mkup(false)
  end)
  aliases:set("mkup_current", function()
    require("notomo.edit").mkup(true)
  end)

  aliases:set("open_vscode", [[execute '!code -r -g %:' .. line('.') .. ':' .. col('.')]])
end)

aliaser.register_factory("github", function(aliases)
  aliases:set("view_issue", function()
    require("notomo.github").view_issue(vim.fn.expand("<cword>"))
  end)
  aliases:set("view_pull_request", function()
    require("notomo.github").view_pr()
  end)
  aliases:set("view_current_repository", function()
    require("notomo.github").view_repo()
  end)
  aliases:set("view_cursor_repository", function()
    require("notomo.github").view_repo(vim.fn.expand("<cWORD>"))
  end)
end)

aliaser.register_factory("ale", function(aliases)
  aliases:set("fix", "ALEFix")
  aliases:set("toggle_fix_on_save", function()
    if vim.b.ale_fix_on_save == nil then
      vim.b.ale_fix_on_save = true
    end
    vim.b.ale_fix_on_save = not vim.b.ale_fix_on_save
    local msg = vim.b.ale_fix_on_save and "enabled" or "disabled"
    print("fix: " .. msg)
  end)
end)
