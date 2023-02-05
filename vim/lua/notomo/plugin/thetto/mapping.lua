vim.api.nvim_create_augroup("thetto_setting", {})

local starter = function(...)
  local args = { ... }
  return function()
    require("thetto").start(unpack(args))
  end
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "thetto_setting",
  pattern = { "thetto" },
  callback = function()
    vim.keymap.set("n", "<CR>", [[<Cmd>lua require("thetto").execute()<CR>]], { buffer = true })
    vim.keymap.set(
      "n",
      "dd",
      [[<Cmd>lua require("thetto").execute("move_to_input")<CR><Esc><Cmd>silent delete _<CR>]],
      { buffer = true }
    )
    vim.keymap.set(
      "n",
      "cc",
      [[<Cmd>lua require("thetto").execute("move_to_input")<CR><Esc><Cmd>silent delete _<CR><Cmd>lua require("thetto").execute("move_to_input")<CR>]],
      { buffer = true }
    )
    vim.keymap.set(
      "n",
      "i",
      [[<Cmd>lua require("thetto").execute("move_to_input", {action_opts = {behavior = "a"}})<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "I", [[<Cmd>lua require("thetto").execute("move_to_input")<CR><Home>]], { buffer = true })
    vim.keymap.set(
      "n",
      "a",
      [[<Cmd>lua require("thetto").execute("move_to_input", {action_opts = {behavior = "a"}})<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "A", [[<Cmd>lua require("thetto").execute("move_to_input")<CR><End>]], { buffer = true })
    vim.keymap.set("n", "q", [[<Cmd>lua require("thetto").execute("quit")<CR>]], { buffer = true, nowait = true })
    vim.keymap.set("n", "o", [[<Cmd>lua require("thetto").execute("open")<CR>]], { buffer = true })
    vim.keymap.set("n", "sv", [[<Cmd>lua require("thetto").execute("vsplit_open")<CR>]], { buffer = true })
    vim.keymap.set("n", "D", [[<Cmd>lua require("thetto").execute("debug_print")<CR>]], { buffer = true })
    vim.keymap.set("n", "t<Space>", [[<Cmd>lua require("thetto").execute("tab_open")<CR>]], { buffer = true })
    vim.keymap.set("n", "j", [[line('.') == line('$') ? 'gg' : 'j']], { buffer = true, expr = true, silent = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true, silent = true })
    vim.keymap.set("n", "<2-LeftMouse>", [[<Cmd>lua require("thetto").execute()<CR>]], {
      buffer = true,
      silent = true,
    })
    vim.keymap.set(
      "i",
      "<2-LeftMouse>",
      [[<Cmd>lua require("thetto").execute()<CR><ESC>]],
      { buffer = true, silent = true }
    )
    vim.keymap.set("n", "<Tab>", starter("thetto/action"), { buffer = true })
    vim.keymap.set("n", "<RightMouse>", [[<Nop>]], { buffer = true })
    vim.keymap.set("n", "<RightDrag>", [[<Nop>]], { buffer = true })
    vim.keymap.set(
      "n",
      "<2-RightMouse>",
      starter("thetto/action", { opts = { insert = false, input_lines = { "open" } } }),
      { buffer = true }
    )
    vim.keymap.set("n", "<C-w>", [[<Cmd>lua require("thetto").execute("quit")<CR>]], { buffer = true })
    vim.keymap.set("n", "sm", [[<Cmd>lua require("thetto").execute("toggle_selection")<CR><Down>]], { buffer = true })
    vim.keymap.set("x", "sm", [[<Cmd>lua require("thetto").execute("toggle_selection")<CR>]], { buffer = true })
    vim.keymap.set("n", "sa", [[<Cmd>lua require("thetto").execute("toggle_all_selection")<CR>]], { buffer = true })
    vim.keymap.set("n", "fo", [[<Cmd>lua require("thetto").execute("directory_open")<CR>]], { buffer = true })
    vim.keymap.set("n", "fl", [[<Cmd>lua require("thetto").execute("directory_tab_open")<CR>]], { buffer = true })
    vim.keymap.set(
      "n",
      "ff",
      [[<Cmd>lua require("thetto").execute("list_children", {fallback_actions = {"list_siblings"}})<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "F", [[<Cmd>lua require("thetto").execute("list_parents")<CR>]], { buffer = true })
    vim.keymap.set("n", "yy", [[<Cmd>lua require("thetto").execute("yank")<CR>]], { buffer = true })
    vim.keymap.set(
      "n",
      "tsl",
      [[<Cmd>lua require("thetto").execute("toggle_sorter", {action_opts = {name = "length"}})<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "p", [[<Cmd>lua require("thetto").execute("toggle_preview")<CR>]], { buffer = true })
    vim.keymap.set(
      "n",
      "[finder]<CR>",
      [[<Cmd>lua require("thetto").execute("resume_previous")<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "[finder]n", [[<Cmd>lua require("thetto").execute("resume_previous")<CR>]], { buffer = true })
    vim.keymap.set("n", "[finder]N", [[<Cmd>lua require("thetto").execute("resume_next")<CR>]], { buffer = true })
    vim.keymap.set("n", "<C-n>", [[<Cmd>lua require("thetto").execute("go_to_next_page")<CR>]], { buffer = true })
    vim.keymap.set("n", "<C-p>", [[<Cmd>lua require("thetto").execute("go_to_previous_page")<CR>]], { buffer = true })

    vim.keymap.set("n", "usg", function()
      require("thetto").start("file/recursive", {
        opts = { cwd = require("thetto.util.cwd").project(nil, require("thetto").get()[1].path) },
      })
    end, { buffer = true })

    vim.keymap.set("n", "usf", function()
      require("thetto").start("file/recursive", {
        opts = { cwd = require("thetto.util.cwd").dir(require("thetto").get()[1].path) },
      })
    end, { buffer = true })

    vim.keymap.set("n", "M", [[<Cmd>lua require("thetto").execute("change_display_limit")<CR>]], { buffer = true })
    vim.keymap.set("n", "R", [[<Cmd>lua require("thetto").execute("reverse")<CR>]], { buffer = true })
    vim.keymap.set("n", "rn", [[<Cmd>lua require("thetto").execute("rename")<CR>]], { buffer = true })

    -- custom
    vim.keymap.set("n", "<Leader>rp", [[<Cmd>lua require("thetto").execute("qfreplace")<CR>]], { buffer = true })
    vim.keymap.set("n", "O", [[<Cmd>lua require("thetto").execute("search")<CR>]], { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "thetto_setting",
  pattern = { "thetto-input" },
  callback = function()
    vim.keymap.set("n", "<CR>", [[<Cmd>lua require("thetto").execute()<CR>]], { buffer = true })
    vim.keymap.set("i", "<CR>", [[<Esc>:lua require("thetto").execute()<CR>]], { buffer = true })
    vim.keymap.set("i", "jq", [[<Cmd>lua require("thetto").execute("quit")<CR><ESC>]], {
      buffer = true,
      silent = true,
    })
    vim.keymap.set("n", "j", [[<Cmd>lua require("thetto").execute("move_to_list")<CR>]], { buffer = true })
    vim.keymap.set("n", "J", [[line('.') == line('$') ? 'gg' : 'j']], { buffer = true, silent = true, expr = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true })
    vim.keymap.set("n", "K", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true })
    vim.keymap.set("n", "q", [[<Cmd>lua require("thetto").execute("quit")<CR>]], { buffer = true })
    vim.keymap.set("n", "o", [[<Cmd>lua require("thetto").execute("open")<CR>]], { buffer = true })
    vim.keymap.set("n", "sv", [[<Cmd>lua require("thetto").execute("vsplit_open")<CR>]], { buffer = true })
    vim.keymap.set("n", "t<Space>", [[<Cmd>lua require("thetto").execute("tab_open")<CR>]], { buffer = true })
    vim.keymap.set(
      "n",
      "fan",
      [[<Cmd>lua require("thetto").execute("add_filter", {action_opts = {name = "-substring"}})<CR>Gi]],
      { buffer = true }
    )
    vim.keymap.set(
      "n",
      "fau",
      [[<Cmd>lua require("thetto").execute("add_filter", {action_opts = {name = "unique:path"}})<CR>Gi]],
      { buffer = true }
    )
    vim.keymap.set(
      "n",
      "faU",
      [[<Cmd>lua require("thetto").execute("remove_filter", {action_opts = {name = "unique:path"}})<CR>Gi]],
      { buffer = true }
    )
    vim.keymap.set("n", "fd", [[<Cmd>lua require("thetto").execute("remove_filter")<CR>]], { buffer = true })
    vim.keymap.set("n", "fi", [[<Cmd>lua require("thetto").execute("inverse_filter")<CR>]], { buffer = true })
    vim.keymap.set("n", "sr", [[<Cmd>lua require("thetto").execute("reverse_sorter")<CR>]], { buffer = true })
    vim.keymap.set(
      "n",
      "[finder]<CR>",
      [[<Cmd>lua require("thetto").execute("resume_previous")<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "[finder]n", [[<Cmd>lua require("thetto").execute("resume_previous")<CR>]], { buffer = true })
    vim.keymap.set("n", "[finder]N", [[<Cmd>lua require("thetto").execute("resume_next")<CR>]], { buffer = true })

    vim.keymap.set("i", "<Tab>", [[<Cmd>lua require("thetto").execute("append_filter_input")<CR>]], { buffer = true })
    vim.keymap.set(
      "i",
      "<C-p>",
      [[<Cmd>lua require("thetto").execute("recall_previous_history")<CR>]],
      { buffer = true }
    )
    vim.keymap.set("i", "<C-n>", [[<Cmd>lua require("thetto").execute("recall_next_history")<CR>]], { buffer = true })

    -- custom
    vim.keymap.set("i", "<C-u>", [[<Cmd>lua require('notomo.edit').delete_prev()<CR>]], { buffer = true })
  end,
})

local source_specific = {
  ["git/log"] = function(list_bufnr)
    vim.keymap.set("n", "yr", function()
      require("notomo.edit").yank(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "yR", function()
      require("notomo.github").yank_revision_with_repo(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "ym", function()
      require("notomo.git").yank_commit_message(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "yu", function()
      require("notomo.github").yank_commit_url(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "ch", [[<Cmd>lua require("thetto").execute("checkout")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "D", [[<Cmd>lua require("thetto").execute("diff")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "RS", [[<Cmd>lua require("thetto").execute("reset")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "F", [[<Cmd>lua require("thetto").execute("fixup")<CR>]], { buffer = list_bufnr })
    vim.keymap.set(
      "n",
      "I",
      [[<Cmd>lua require("thetto").execute("rebase_interactively")<CR>]],
      { buffer = list_bufnr }
    )
  end,
  ["git/change"] = function(list_bufnr)
    vim.keymap.set("n", "dd", [[<Cmd>lua require("thetto").execute("compare")<CR>]], { buffer = list_bufnr })
  end,
  ["git/branch"] = function(list_bufnr)
    vim.keymap.set("n", "C", [[<Cmd>lua require("thetto").execute("create")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "yr", function()
      require("notomo.edit").yank(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
  end,
  ["git/status"] = function(list_bufnr)
    vim.keymap.set(
      { "n", "x" },
      "[git]a",
      [[<Cmd>lua require("thetto").execute("toggle_stage")<CR>]],
      { buffer = list_bufnr }
    )
    vim.keymap.set({ "n", "x" }, "U", [[<Cmd>lua require("thetto").execute("discard")<CR>]], { buffer = list_bufnr })
    vim.keymap.set({ "n", "x" }, "S", [[<Cmd>lua require("thetto").execute("stash")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "cc", [[<Cmd>lua require("thetto").execute("commit")<CR>]], { buffer = list_bufnr })
    vim.keymap.set(
      "n",
      "ca",
      [[<Cmd>lua require("thetto").execute("commit_amend", {allow_no_items = true})<CR>]],
      { buffer = list_bufnr }
    )
    vim.keymap.set("n", "dd", [[<Cmd>lua require("thetto").execute("compare")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "D", [[<Cmd>lua require("thetto").execute("diff")<CR>]], { buffer = list_bufnr })

    local move = function(flag, fallback_key)
      local _, column = unpack(vim.api.nvim_win_get_cursor(0))
      vim.cmd.normal({ args = { "0" }, bang = true })
      local result = vim.fn.search("^    ", flag)
      if result == 0 then
        vim.cmd.normal({ args = { fallback_key }, bang = true })
      end
      vim.cmd.nohlsearch()
      vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), column })
    end
    vim.keymap.set("n", "j", function()
      move("w", "j")
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "k", function()
      move("bw", "k")
    end, { buffer = list_bufnr })
  end,
  ["git/stash"] = function(list_bufnr)
    vim.keymap.set("n", "pop", [[<Cmd>lua require("thetto").execute("pop")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "AP", [[<Cmd>lua require("thetto").execute("apply")<CR>]], { buffer = list_bufnr })
  end,
  ["cmd/make/target"] = function(list_bufnr)
    vim.keymap.set("n", "P", [[<Cmd>lua require("thetto").execute("dry_run")<CR>]], { buffer = list_bufnr })
  end,
}
vim.api.nvim_create_autocmd({ "User" }, {
  group = "thetto_setting",
  pattern = { "ThettoOpened" },
  callback = function(args)
    local f = source_specific[args.data.source_name]
    if f then
      f(args.data.list_bufnr)
    end
  end,
})

vim.keymap.set("n", "[finder]R", starter("vim/runtimepath"))
vim.keymap.set("n", "[finder]W", starter("cmd/whereis"))
vim.keymap.set("n", "<Space>ur", starter("file/mru", { opts = { cwd = require("thetto.util.cwd").project() } }))
vim.keymap.set("n", "[finder]<CR>", function()
  require("thetto").resume()
end)
vim.keymap.set("n", "<Space>usf", starter("file/recursive"))
vim.keymap.set("n", "[finder]f", starter("file/in_dir"))
vim.keymap.set("n", "[finder]h", starter("vim/help"))
vim.keymap.set("n", "[finder]l", starter("line"))
vim.keymap.set("n", "[finder]L", function()
  local row_range, err = require("notomo.treesitter").get_current_function_range()
  if err then
    error(err)
  end
  require("thetto").start("line", {
    source_opts = {
      start_row = row_range[1],
      end_row = row_range[2] + 1,
    },
  })
end)
vim.keymap.set(
  "n",
  "[finder]r",
  starter("file/directory/recursive", { opts = { cwd = require("thetto.util.cwd").project() } })
)
vim.keymap.set("n", "<Space>usd", starter("file/directory/recursive"))

local ls_opts = {}
if vim.fn.has("win32") == 1 then
  ls_opts = {
    get_command = function()
      return { "git", "ls-files", "--full-name" }
    end,
    to_absolute = function(cwd, path)
      return cwd .. "/" .. path
    end,
  }
end
vim.keymap.set(
  "n",
  "<Space>usg",
  starter("file/recursive", {
    opts = { cwd = require("thetto.util.cwd").project() },
    source_opts = ls_opts,
  })
)
vim.keymap.set(
  "n",
  "[finder]v",
  starter("file/recursive", {
    opts = { cwd = "~/dotfiles" },
    source_opts = ls_opts,
  })
)

vim.keymap.set("n", "[finder]O", starter("vim/option"))
vim.keymap.set("n", "[finder]H", starter("vim/highlight_group"))
vim.keymap.set("n", "[finder]B", starter("vim/buffer"))
vim.keymap.set("n", "[finder]y", starter("file/bookmark"))

vim.keymap.set("n", "[finder]ga", starter("git/branch", { opts = { sorters = { "length" } } }))
vim.keymap.set(
  "n",
  "[finder]gA",
  starter("git/branch", {
    opts = { sorters = { "length" } },
    source_opts = { all = true },
    action_opts = { track = true },
  })
)
vim.keymap.set("n", "[git]b", starter("git/branch"))
vim.keymap.set("n", "[git]dl", starter("git/deleted_file"))

vim.keymap.set("n", "[finder]gt", starter("git/tag"))
vim.keymap.set("n", "[finder]gT", starter("git/tag", { source_opts = { merged = true } }))
vim.keymap.set(
  "n",
  "[finder]go",
  starter("file/directory/recursive", { opts = { cwd = "$GOPATH/src" }, source_opts = { max_depth = 3 } })
)
vim.keymap.set("n", "[git]xl", starter("git/stash"))
vim.keymap.set("n", "[git]xs", starter("git/stash", { opts = { immediately = true, action = "create" } }))
vim.keymap.set(
  "n",
  "[keyword]gg",
  starter("file/grep", {
    opts = {
      cwd = require("thetto.util.cwd").project(),
      pattern = function()
        return vim.fn.expand("<cword>")
      end,
    },
  })
)
vim.keymap.set("n", "[finder]gl", starter("file/grep"), { silent = true })
vim.keymap.set(
  "n",
  "[finder]gg",
  starter("file/grep", { opts = { cwd = require("thetto.util.cwd").project() } }),
  { silent = true }
)
vim.keymap.set("n", "[finder]P", starter("cmd/procs"))
vim.keymap.set("n", "[finder]A", starter("vim/autocmd"))
vim.keymap.set("n", "[finder]s", starter("thetto/source"))
vim.keymap.set("n", "[finder]n", function()
  require("thetto").resume_execute({ opts = { offset = 1 } })
end)
vim.keymap.set("n", "[finder]N", function()
  require("thetto").resume_execute({ opts = { offset = -1 } })
end)
vim.keymap.set("n", "[finder]gn", function()
  require("thetto").resume_execute({ opts = { offset = 100000 } })
end)
vim.keymap.set("n", "[finder]gN", function()
  require("thetto").resume_execute({ opts = { offset = -100000 } })
end)
vim.keymap.set("n", "[finder]m", starter("listdefined/keymap"))
vim.keymap.set("n", "[finder]o", starter("cmd/ctags"))
vim.keymap.set("n", "[exec],", starter("cmd/make/target"))
vim.keymap.set("n", "[finder]S", starter("vim/substitute"))
vim.keymap.set("x", "[finder]s", starter("vim/substitute"))
vim.keymap.set("n", "[git]ll", starter("git/log"))
vim.keymap.set("n", "[git]fl", starter("git/file_log"))
vim.keymap.set("n", "[git]s", function()
  require("thetto").start("git/status", {
    opts = {
      search_offset = function(item)
        return item.path ~= nil
      end,
    },
  })
end)
vim.keymap.set("n", "[git]B", function()
  local row = vim.fn.line(".")
  require("thetto").start("git/blame", {
    opts = {
      insert = false,
      display_limit = row + 100,
      search_offset = function(item)
        return item.row == row
      end,
    },
  })
end)

vim.keymap.set("n", "[finder]gd", starter("git/diff"))
vim.keymap.set("n", "[finder]gr", starter("git/diff", { source_opts = { expr = "%:p" } }))
vim.keymap.set(
  "n",
  "[finder]G",
  starter("file/grep", {
    opts = {
      cwd = require("thetto.util.cwd").project(),
      filters = require("thetto.util.filter").prepend("interactive"),
    },
  })
)
vim.keymap.set(
  "n",
  "[finder]gL",
  starter("file/grep", {
    opts = {
      filters = require("thetto.util.filter").prepend("interactive"),
    },
  })
)

vim.keymap.set("n", "[file]f", starter("file/alter"))
vim.keymap.set("n", "[file]F", function()
  require("thetto").start("file/alter", {
    opts = { action = "tab_open" },
    source_opts = {
      pattern_groups = {
        { "%/lua/thetto/handler/source/%.lua", "%/lua/thetto/handler/kind/%.lua" },
      },
    },
  })
end)
vim.keymap.set("n", "[file]l", starter("file/alter", { opts = { action = "tab_open" } }))
vim.keymap.set("n", "[file]t", starter("file/alter", { source_opts = { allow_new = true } }))
vim.keymap.set("n", "[file];", function()
  local function_name = require("notomo.treesitter").get_near_function_name()
  require("thetto").start("file/alter"):next(function()
    require("thetto").start("test", {
      opts = {
        immediately = true,
        insert = false,
        input_lines = { function_name },
      },
    })
  end)
end)

vim.keymap.set("n", "[finder]T", starter("vim/buffer", { source_opts = { buftype = "terminal" } }))
vim.keymap.set("n", "[exec]cv", starter("vim/execute", { source_opts = { cmd = "version" } }))
vim.keymap.set("n", "[finder]J", starter("vim/jump"))
vim.keymap.set("n", "[finder]c", starter("vim/command"))
vim.keymap.set("n", "[finder]M", starter("env/manual"))
vim.keymap.set("n", "[finder]q", starter("cmd/jq"))
vim.keymap.set("n", "[finder]gR", starter("cmd/gron"))
vim.keymap.set("n", "[finder]jl", starter("vim/jump", { source_opts = { per_file = true } }))
vim.keymap.set("n", "[finder]z", starter("cmd/zsh/history"))
vim.keymap.set("n", "[finder]Q", starter("vim/history/command"))
vim.keymap.set("n", "[finder]gP", starter("github/pull_request"))
vim.keymap.set("n", "[finder]to", starter("test"))
vim.keymap.set("n", "[finder]ts", starter("test", { source_opts = { scope = "largest_ancestor" } }))
vim.keymap.set("n", "[finder]b", starter("url/bookmark"))

-- custom source
vim.keymap.set("n", "[finder]p", starter("plugin"))
vim.keymap.set("n", "[finder]e", starter("emoji"))
vim.keymap.set("n", "[finder]gp", starter("go/package"))
vim.keymap.set("n", "[finder]a", starter("aliaser"))
vim.keymap.set("n", "[finder]d", starter("vim/diagnostic"))
vim.keymap.set(
  "n",
  "[finder]D",
  starter("vim/diagnostic", {
    opts = { cwd = require("thetto.util.cwd").project() },
    source_opts = { args = {} },
  })
)
vim.keymap.set("n", "[finder]w", starter("vim/lsp/workspace_symbol"))
vim.keymap.set("n", "[exec]gr", starter("vim/lsp/references"))
vim.keymap.set("n", "[keyword]n", function()
  vim.lsp.buf.clear_references()
  vim.lsp.buf.document_highlight()

  local current_row = vim.fn.line(".")
  local path = vim.api.nvim_buf_get_name(0)
  require("thetto").start("vim/lsp/references", {
    opts = {
      insert = false,
      action = "open",
      search_offset = function(item)
        return item.path == path and item.row == current_row
      end,
    },
  })
end)
vim.keymap.set("n", "[keyword]O", starter("vim/lsp/outgoing_calls"))
vim.keymap.set("n", "[keyword]I", starter("vim/lsp/incoming_calls"))

vim.keymap.set("n", "[git]D", function()
  local git_root, err = require("thetto.util.git").root()
  if err then
    return require("misclib.message").warn(err)
  end
  local bufnr = require("thetto.util.git").diff_buffer()
  require("thetto.util.git").diff(git_root, bufnr):next(function()
    require("thetto.lib.buffer").open_scratch_tab()
    vim.cmd.buffer(bufnr)
  end)
end)
vim.keymap.set("n", "[git]dd", function()
  local git_root, err = require("thetto.util.git").root()
  if err then
    return require("misclib.message").warn(err)
  end
  local path = vim.api.nvim_buf_get_name(0)
  require("thetto.util.git").compare(git_root, path, "HEAD", path)
end)

-- custom action
vim.keymap.set("n", "[finder];", starter("vim/filetype", { opts = { action = "open_scratch" } }))
