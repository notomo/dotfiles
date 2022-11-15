vim.api.nvim_create_augroup("thetto_setting", {})

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
    vim.keymap.set("n", "<Tab>", [[<Cmd>lua require("thetto").start("thetto/action")<CR>]], { buffer = true })
    vim.keymap.set("n", "<RightMouse>", [[<Nop>]], { buffer = true })
    vim.keymap.set("n", "<RightDrag>", [[<Nop>]], { buffer = true })
    vim.keymap.set(
      "n",
      "<2-RightMouse>",
      [[<Cmd>lua require("thetto").start("thetto/action", {opts = {insert = false, input_lines = {"open"}}})<CR>]],
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
  ["git/branch"] = function(list_bufnr)
    vim.keymap.set("n", "C", [[<Cmd>lua require("thetto").execute("create")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "yr", function()
      require("notomo.edit").yank(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
  end,
  ["git/status"] = function(list_bufnr)
    vim.keymap.set("n", "[git]a", [[<Cmd>lua require("thetto").execute("toggle_stage")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "U", [[<Cmd>lua require("thetto").execute("discard")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "S", [[<Cmd>lua require("thetto").execute("stash")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "cc", [[<Cmd>lua require("thetto").execute("commit")<CR>]], { buffer = list_bufnr })
    vim.keymap.set("n", "ca", [[<Cmd>lua require("thetto").execute("commit_amend")<CR>]], { buffer = list_bufnr })
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

vim.keymap.set("n", "[finder]R", [[<Cmd>lua require("thetto").start("vim/runtimepath")<CR>]])
vim.keymap.set("n", "[finder]W", [[<Cmd>lua require("thetto").start("cmd/whereis")<CR>]])
vim.keymap.set("n", "<Space>ur", function()
  require("thetto").start("file/mru", { opts = { cwd = require("thetto.util.cwd").project() } })
end)
vim.keymap.set("n", "[finder]<CR>", [[<Cmd>lua require("thetto").resume()<CR>]])
vim.keymap.set("n", "<Space>usf", [[<Cmd>lua require("thetto").start("file/recursive")<CR>]])
vim.keymap.set("n", "[finder]f", [[<Cmd>lua require("thetto").start("file/in_dir")<CR>]])
vim.keymap.set("n", "[finder]h", [[<Cmd>lua require("thetto").start("vim/help")<CR>]])
vim.keymap.set("n", "[finder]l", [[<Cmd>lua require("thetto").start("line")<CR>]])
vim.keymap.set("n", "[finder]r", function()
  require("thetto").start("file/directory/recursive", { opts = { cwd = require("thetto.util.cwd").project() } })
end)
vim.keymap.set("n", "<Space>usd", [[<Cmd>lua require("thetto").start("file/directory/recursive")<CR>]])

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
vim.keymap.set("n", "<Space>usg", function()
  require("thetto").start("file/recursive", {
    opts = { cwd = require("thetto.util.cwd").project() },
    source_opts = ls_opts,
  })
end)
vim.keymap.set("n", "[finder]v", function()
  require("thetto").start("file/recursive", {
    opts = { cwd = "~/dotfiles" },
    source_opts = ls_opts,
  })
end)

vim.keymap.set("n", "[finder]O", [[<Cmd>lua require("thetto").start("vim/option")<CR>]])
vim.keymap.set("n", "[finder]H", [[<Cmd>lua require("thetto").start("vim/highlight_group")<CR>]])
vim.keymap.set("n", "[finder]B", [[<Cmd>lua require("thetto").start("vim/buffer")<CR>]])
vim.keymap.set("n", "[finder]y", [[<Cmd>lua require("thetto").start("file/bookmark")<CR>]])

vim.keymap.set("n", "[finder]ga", function()
  require("thetto").start("git/branch", { opts = { sorters = { "length" } } })
end)
vim.keymap.set("n", "[finder]gA", function()
  require("thetto").start("git/branch", {
    opts = { sorters = { "length" } },
    source_opts = { all = true },
    action_opts = { track = true },
  })
end)
vim.keymap.set("n", "[git]b", function()
  require("thetto").start("git/branch", { opts = { insert = false } })
end)

vim.keymap.set("n", "[finder]gt", [[<Cmd>lua require("thetto").start("git/tag")<CR>]])
vim.keymap.set("n", "[finder]gT", [[<Cmd>lua require("thetto").start("git/tag", {source_opts = {merged = true}})<CR>]])
vim.keymap.set(
  "n",
  "[finder]go",
  [[<Cmd>lua require("thetto").start("file/directory/recursive", {opts = {cwd = "$GOPATH/src"}, source_opts = {max_depth = 3}})<CR>]]
)
vim.keymap.set("n", "[git]xl", [[<Cmd>lua require("thetto").start("git/stash", { opts = { insert = false }})<CR>]])
vim.keymap.set("n", "[git]xs", function()
  require("thetto").start("git/stash", { opts = { immediately = true, action = "create" } })
end)
vim.keymap.set("n", "[keyword]gg", function()
  require("thetto").start("file/grep", {
    opts = {
      cwd = require("thetto.util.cwd").project(),
      pattern = function()
        return vim.fn.expand("<cword>")
      end,
    },
  })
end)
vim.keymap.set("n", "[finder]gl", [[<Cmd>lua require("thetto").start("file/grep")<CR>]], { silent = true })
vim.keymap.set("n", "[finder]gg", function()
  require("thetto").start("file/grep", { opts = { cwd = require("thetto.util.cwd").project() } })
end, { silent = true })
vim.keymap.set("n", "[finder]P", [[<Cmd>lua require("thetto").start("env/process")<CR>]])
vim.keymap.set("n", "[finder]A", [[<Cmd>lua require("thetto").start("vim/autocmd")<CR>]])
vim.keymap.set("n", "[finder]s", [[<Cmd>lua require("thetto").start("thetto/source")<CR>]])
vim.keymap.set("n", "[finder]n", [[<Cmd>lua require("thetto").resume_execute({opts = {offset = 1}})<CR>]])
vim.keymap.set("n", "[finder]N", [[<Cmd>lua require("thetto").resume_execute({opts = {offset = -1}})<CR>]])
vim.keymap.set("n", "[finder]gn", [[<Cmd>lua require("thetto").resume_execute({opts = {offset = 100000}})<CR>]])
vim.keymap.set("n", "[finder]gN", [[<Cmd>lua require("thetto").resume_execute({opts = {offset = -100000}})<CR>]])
vim.keymap.set("n", "[finder]m", [[<Cmd>lua require("thetto").start("keymap")<CR>]])
vim.keymap.set("n", "[finder]o", [[<Cmd>lua require("thetto").start("cmd/ctags")<CR>]])
vim.keymap.set("n", "[finder],", function()
  require("thetto").start("cmd/make/target", { opts = { cwd = require("thetto.util.cwd").project() } })
end)
vim.keymap.set("n", "[exec],", function()
  require("thetto").start(
    "cmd/make/target",
    { opts = { cwd = require("thetto.util.cwd").upward({ "Makefile" }), insert = false } }
  )
end)
vim.keymap.set("n", "[finder]S", [[<Cmd>lua require("thetto").start("vim/substitute")<CR>]])
vim.keymap.set("x", "[finder]s", [[<Cmd>lua require("thetto").start("vim/substitute")<CR>]])
vim.keymap.set("n", "[finder]gs", function()
  require("thetto").start("git/status", { opts = { cwd = require("thetto.util.cwd").project() } })
end)
vim.keymap.set("n", "[finder]gd", function()
  require("thetto").start("git/diff", { opts = { cwd = require("thetto.util.cwd").project() } })
end)
vim.keymap.set("n", "[finder]gr", function()
  require("thetto").start(
    "git/diff",
    { opts = { cwd = require("thetto.util.cwd").project() }, source_opts = { expr = "%:p" } }
  )
end)
vim.keymap.set("n", "[finder]G", function()
  require("thetto").start("file/grep", {
    opts = {
      cwd = require("thetto.util.cwd").project(),
      filters = require("thetto.util.filter").prepend("interactive"),
    },
  })
end)
vim.keymap.set("n", "[finder]gL", function()
  require("thetto").start("file/grep", {
    opts = {
      filters = require("thetto.util.filter").prepend("interactive"),
    },
  })
end)

vim.keymap.set("n", "[file]f", [[<Cmd>lua require("thetto").start("file/alter")<CR>]])
vim.keymap.set("n", "[file]l", [[<Cmd>lua require("thetto").start("file/alter", {opts = {action = "tab_open"}})<CR>]])
vim.keymap.set(
  "n",
  "[file]t",
  [[<Cmd>lua require("thetto").start("file/alter", {source_opts = {allow_new = true}})<CR>]]
)
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

vim.keymap.set(
  "n",
  "[finder]T",
  [[<Cmd>lua require("thetto").start("vim/buffer", {source_opts = {buftype = "terminal"}})<CR>]]
)
vim.keymap.set(
  "n",
  "[exec]cv",
  [[<Cmd>lua require("thetto").start("vim/execute", {source_opts = {cmd = "version"}})<CR>]]
)
vim.keymap.set("n", "[finder]J", [[<Cmd>lua require("thetto").start("vim/jump")<CR>]])
vim.keymap.set("n", "[finder]c", [[<Cmd>lua require("thetto").start("vim/command")<CR>]])
vim.keymap.set("n", "[finder]M", [[<Cmd>lua require("thetto").start("env/manual")<CR>]])
vim.keymap.set("n", "[finder]q", function()
  require("thetto").start("cmd/jq", { opts = { filters = require("thetto.util.filter").prepend("interactive") } })
end)
vim.keymap.set("n", "[finder]gR", [[<Cmd>lua require("thetto").start("cmd/gron")<CR>]])
vim.keymap.set(
  "n",
  "[finder]jl",
  [[<Cmd>lua require("thetto").start("vim/jump", {source_opts = {per_file = true}})<CR>]]
)
vim.keymap.set("n", "[finder]z", [[<Cmd>lua require("thetto").start("cmd/zsh/history")<CR>]])
vim.keymap.set("n", "[finder]Q", [[<Cmd>lua require("thetto").start("vim/history/command")<CR>]])
vim.keymap.set("n", "[finder]gP", [[<Cmd>lua require("thetto").start("github/pull_request")<CR>]])
vim.keymap.set("n", "[finder]to", [[<Cmd>lua require("thetto").start("test", {opts = {action = "execute"}})<CR>]])
vim.keymap.set(
  "n",
  "[finder]ts",
  [[<Cmd>lua require("thetto").start("test", {source_opts = {scoped = true}, opts = {action = "execute"}})<CR>]]
)
vim.keymap.set("n", "[finder]b", [[<Cmd>lua require("thetto").start("url/bookmark")<CR>]])

-- custom source
vim.keymap.set("n", "[finder]p", [[<Cmd>lua require("thetto").start("plugin")<CR>]])
vim.keymap.set(
  "n",
  "[finder]e",
  [[<Cmd>lua require("thetto").start("emoji", {opts = {action = "append"}, action_opts = {key = "emoji"}})<CR>]]
)
vim.keymap.set("n", "[finder]gp", [[<Cmd>lua require("thetto").start("go/package")<CR>]])
vim.keymap.set("n", "[finder]a", [[<Cmd>lua require("thetto").start("aliaser")<CR>]])
vim.keymap.set("n", "[finder]d", [[<Cmd>lua require("thetto").start("vim/diagnostic")<CR>]])
vim.keymap.set("n", "[finder]D", function()
  require("thetto").start("vim/diagnostic", {
    opts = { cwd = require("thetto.util.cwd").project() },
    source_opts = { args = {} },
  })
end)
vim.keymap.set("n", "[finder]w", [[<Cmd>lua require("thetto").start("vim/lsp/workspace_symbol")<CR>]])
vim.keymap.set("n", "[exec]gr", [[<Cmd>lua require("thetto").start("vim/lsp/references")<CR>]])
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
vim.keymap.set("n", "[keyword]O", [[<Cmd>lua require("thetto").start("vim/lsp/outgoing_calls")<CR>]])
vim.keymap.set("n", "[keyword]I", [[<Cmd>lua require("thetto").start("vim/lsp/incoming_calls")<CR>]])

-- custom action
vim.keymap.set(
  "n",
  "[finder];",
  [[<Cmd>lua require("thetto").start("vim/filetype", {opts = {action = "open_scratch"}})<CR>]]
)
