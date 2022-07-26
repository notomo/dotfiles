local aliaser = require("aliaser")

aliaser.register_factory("thetto", function(aliases)
  aliases:set("assigned_issues", function()
    require("thetto").start("github/issue", { source_opts = { assignee = "me" } })
  end)
end)

aliaser.register_factory("buffer", function(aliases)
  aliases:set("reverse", function()
    vim.cmd.global([[/^/m0]])
    vim.cmd.nohlsearch()
  end)
end)

aliaser.register_factory("tree_sitter", function(aliases)
  aliases:set("query", function()
    require("nvimtool").tree.query()
  end)
  aliases:set("ready_parser", function()
    for _, language in ipairs({
      "lua",
      "go",
    }) do
      vim.cmd.TSInstall(language)
    end
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
      vim.cmd.source(vim.env.MYVIMRC)
    end
    vim.cmd.nohlsearch()
  end)

  aliases:set("diff", function()
    local window_ids = vim.api.nvim_tabpage_list_wins(0)
    if #window_ids ~= 2 then
      return require("misclib.message").warn(("must have 2 windows, but: %d"):format(#window_ids))
    end
    for _, window_id in ipairs(window_ids) do
      vim.api.nvim_win_call(window_id, function()
        vim.cmd.diffthis()
      end)
    end
  end)

  aliases:set("generate_helptags", function()
    require("cmdhndlr").run({
      name = "make/make",
      working_dir_marker = function()
        return vim.fn.expand("~/dotfiles/vim/Makefile")
      end,
      runner_opts = { target = "help_tags" },
    })
  end)

  aliases:set("install_plugins", function()
    require("optpack").install()
  end)

  aliases:set("start_debug", function()
    require("osv").run_this()
  end)

  aliases:set("test_highlight", function()
    vim.cmd.tabedit()
    vim.cmd.source([[$VIMRUNTIME/syntax/hitest.vim]])
    vim.cmd.only()
  end)

  aliases:set("show_highlight_under_cursor", function()
    local hl_group = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)), "name")
    if hl_group ~= "" then
      vim.api.nvim_echo({ { "" } }, false, {})
      print(hl_group)
      vim.cmd.highlight(hl_group)
    else
      print("no hl_group")
    end
  end)
end)

aliaser.register_factory("dev", function(aliases)
  local colorscheme = "ultramarine"
  aliases:set("watch_" .. colorscheme, function()
    require("notomo.colorscheme").watch(colorscheme, colorscheme .. ".nvim")
  end)
end)

aliaser.register_factory("other", function(aliases)
  aliases:set("mkup_document_root", function()
    require("notomo.edit").mkup(false)
  end)
  aliases:set("mkup_current", function()
    require("notomo.edit").mkup(true)
  end)

  local open_line = function()
    local path = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".") .. ":" .. vim.fn.col(".")
    vim.cmd["!"]({ args = { "code", "-r", "-g", path } })
  end
  aliases:set("open_line_in_vscode", open_line)
  aliases:set("open_repo_in_vscode", function()
    local path = vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h")
    vim.cmd["!"]({ args = { "code", "-r", path } })
    open_line()
  end)
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

aliaser.register_factory("package_json", function(aliases)
  aliases:set("update", function()
    require("notomo.npm.package_json").update(vim.fn.expand("%:p"))
  end)
end)

aliaser.register_factory("format", function(aliases)
  aliases:set("toggle", function()
    local disabled = vim.b.notomo_lsp_format_disabled
    vim.b.notomo_lsp_format_disabled = not disabled
  end)
end)
