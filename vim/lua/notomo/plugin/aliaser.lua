local aliaser = require("aliaser")

aliaser.clear_all()

aliaser.register_factory("buffer", function(aliases)
  aliases:set("reverse", function()
    vim.cmd.global([[/^/m0]])
    vim.cmd.nohlsearch()
  end)
end)

aliaser.register_factory("tree_sitter", function(aliases)
  aliases:set("query", function()
    local runtime_dir = vim.fn.stdpath("cache") .. "/notomo"
    local dir = runtime_dir .. "/queries/" .. vim.bo.filetype
    local query_path = dir .. "/scratch.scm"
    vim.fn.writefile({}, query_path, "p")
    vim.opt.runtimepath:append(runtime_dir)
    local target_bufnr = vim.api.nvim_get_current_buf()
    vim.treesitter.inspect_tree()
    vim.cmd.wincmd("r")
    vim.cmd.wincmd("=")
    require("notomo.lib.treesitter.query").open(query_path, target_bufnr)
  end)
  aliases:set("ready_parser", function()
    for _, language in ipairs({
      "go",
      "typescript",
      "terraform",
      "graphql",
    }) do
      vim.cmd.TSInstall(language)
    end
  end)
end)

aliaser.register_factory("vim", function(aliases)
  aliases:set("clear_messages", "messages clear")

  aliases:set("hlmsg", function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    require("hlmsg").render(bufnr)
    vim.cmd.tabedit()
    vim.cmd.buffer(bufnr)
    require("misclib.cursor").to_bottom()
  end)

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
        return vim.fn.expand("$DOTFILES/vim/Makefile")
      end,
      runner_opts = { target = "help_tags" },
    })
  end)

  aliases:set("install_plugins", function()
    require("optpack").install()
  end)

  aliases:set("preview", function()
    vim.cmd.PrevimOpen()
  end)

  aliases:set("start_debug", function()
    require("osv").run_this()
  end)

  aliases:set("test_highlight", function()
    vim.cmd.tabedit()
    vim.cmd.source([[$VIMRUNTIME/syntax/hitest.vim]])
    vim.cmd.only()
  end)

  aliases:set("toggle_color", function()
    vim.cmd.CccHighlighterToggle()
  end)

  aliases:set("inspect", function()
    vim.cmd.Inspect({ bang = true })
  end)
end)

aliaser.register_factory("other", function(aliases)
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
    require("notomo.lib.github").view_issue(vim.fn.expand("<cword>"))
  end)
  aliases:set("view_pull_request", function()
    require("notomo.lib.github").view_pr()
  end)
  aliases:set("view_current_repository", function()
    require("notomo.lib.github").view_repo()
  end)
  aliases:set("view_cursor_repository", function()
    require("notomo.lib.github").view_repo(vim.fn.expand("<cWORD>"))
  end)
  aliases:set("create_issue", function()
    require("notomo.lib.github").create_issue()
  end)
end)

aliaser.register_factory("package_json", function(aliases)
  aliases:set("update", function()
    require("notomo.lib.npm").update(vim.fn.expand("%:p"))
  end)
end)

aliaser.register_factory("format", function(aliases)
  aliases:set("toggle", function()
    local disabled = vim.b.notomo_lsp_format_disabled
    vim.b.notomo_lsp_format_disabled = not disabled
  end)
end)
