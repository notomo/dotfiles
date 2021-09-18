local aliaser = require("aliaser")

aliaser.register_factory("thetto", function(aliases)
  aliases:set("assigned_issues", function()
    require("thetto").start("github/issue", {source_opts = {assignee = "me"}})
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

  aliases:set("check_health", "checkhealth")
  aliases:set("update_remote_plugin", "call notomo#vimrc#update_remote_plugin()")
end)

aliaser.register_factory("other", function(aliases)
  aliases:set("mkup_document_root", "call notomo#vimrc#mkup(v:false)")
  aliases:set("mkup_current", "call notomo#vimrc#mkup(v:true)")

  aliases:set("open_vscode", [[execute '!code -r -g %:' .. line('.') .. ':' .. col('.')]])
end)

aliaser.register_factory("github", function(aliases)
  aliases:set("view_issue", "call notomo#github#view_issue(expand('<cword>'))")
  aliases:set("view_pull_request", "call notomo#github#view_pr()")
  aliases:set("view_current_repository", "call notomo#vimrc#job(['gh', 'repo', 'view', '--web'])")
  aliases:set("view_cursor_repository", "call notomo#github#view_repo(expand('<cWORD>'))")
end)
