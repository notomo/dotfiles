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
    vim.keymap.set("n", "P", [[<Cmd>lua require("thetto").execute("dry_run")<CR>]], { buffer = true })
    vim.keymap.set(
      "n",
      "[finder]<CR>",
      [[<Cmd>lua require("thetto").execute("resume_previous")<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "[finder]n", [[<Cmd>lua require("thetto").execute("resume_previous")<CR>]], { buffer = true })
    vim.keymap.set("n", "[finder]N", [[<Cmd>lua require("thetto").execute("resume_next")<CR>]], { buffer = true })

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
    vim.keymap.set("n", "<CR>", [[<Esc>:lua require("thetto").execute()<CR>]], { buffer = true })
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

    -- custom
    vim.keymap.set("n", "<C-u>", [[<Cmd>lua require('notomo.edit').delete_prev()<CR>]], { buffer = true })
  end,
})

vim.keymap.set("n", "[finder]R", [[<Cmd>lua require("thetto").start("vim/runtimepath")<CR>]])
vim.keymap.set("n", "<Space>ur", function()
  require("thetto").start("file/mru", { opts = { cwd = require("thetto.util").cwd.project() } })
end)
vim.keymap.set("n", "[finder]<CR>", [[<Cmd>lua require("thetto").resume()<CR>]])
vim.keymap.set("n", "<Space>usf", [[<Cmd>lua require("thetto").start("file/recursive")<CR>]])
vim.keymap.set("n", "[finder]f", [[<Cmd>lua require("thetto").start("file/in_dir")<CR>]])
vim.keymap.set("n", "[finder]h", [[<Cmd>lua require("thetto").start("vim/help")<CR>]])
vim.keymap.set("n", "[finder]l", [[<Cmd>lua require("thetto").start("line")<CR>]])
vim.keymap.set("n", "[finder]r", function()
  require("thetto").start("file/directory/recursive", { opts = { cwd = require("thetto.util").cwd.project() } })
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
    opts = { cwd = require("thetto.util").cwd.project() },
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
vim.keymap.set("n", "[finder]ga", [[<Cmd>lua require("thetto").start("git/branch")<CR>]])
vim.keymap.set(
  "n",
  "[finder]gA",
  [[<Cmd>lua require("thetto").start("git/branch", {source_opts = {all = true}, action_opts = {track = true}})<CR>]]
)
vim.keymap.set("n", "[finder]gt", [[<Cmd>lua require("thetto").start("git/tag")<CR>]])
vim.keymap.set("n", "[finder]gT", [[<Cmd>lua require("thetto").start("git/tag", {source_opts = {merged = true}})<CR>]])
vim.keymap.set(
  "n",
  "[finder]go",
  [[<Cmd>lua require("thetto").start("file/directory/recursive", {opts = {cwd = "$GOPATH/src"}, source_opts = {max_depth = 3}})<CR>]]
)
vim.keymap.set("n", "[keyword]gg", function()
  require("thetto").start("file/grep", {
    opts = {
      cwd = require("thetto.util").cwd.project(),
      pattern = function()
        return vim.fn.expand("<cword>")
      end,
    },
  })
end)
vim.keymap.set("n", "[finder]gl", [[<Cmd>lua require("thetto").start("file/grep")<CR>]], { silent = true })
vim.keymap.set("n", "[finder]gg", function()
  require("thetto").start("file/grep", { opts = { cwd = require("thetto.util").cwd.project() } })
end, { silent = true })
vim.keymap.set("n", "[finder]P", [[<Cmd>lua require("thetto").start("env/process")<CR>]])
vim.keymap.set("n", "[finder]A", [[<Cmd>lua require("thetto").start("vim/autocmd")<CR>]])
vim.keymap.set("n", "[finder]s", [[<Cmd>lua require("thetto").start("thetto/source")<CR>]])
vim.keymap.set("n", "[finder]n", [[<Cmd>lua require("thetto").resume_execute({opts = {offset = 1}})<CR>]])
vim.keymap.set("n", "[finder]N", [[<Cmd>lua require("thetto").resume_execute({opts = {offset = -1}})<CR>]])
vim.keymap.set("n", "[finder]m", [[<Cmd>lua require("thetto").start("keymap")<CR>]])
vim.keymap.set("n", "[finder]o", [[<Cmd>lua require("thetto").start("cmd/ctags")<CR>]])
vim.keymap.set("n", "[finder],", function()
  require("thetto").start("cmd/make/target", { opts = { cwd = require("thetto.util").cwd.project() } })
end)
vim.keymap.set("n", "[exec],", function()
  require("thetto").start(
    "cmd/make/target",
    { opts = { cwd = require("thetto.util").cwd.upward({ "Makefile" }), insert = false } }
  )
end)
vim.keymap.set("n", "[finder]S", [[<Cmd>lua require("thetto").start("vim/substitute")<CR>]])
vim.keymap.set("x", "[finder]s", [[<Cmd>lua require("thetto").start("vim/substitute")<CR>]])
vim.keymap.set("n", "[finder]gs", function()
  require("thetto").start("git/status", { opts = { cwd = require("thetto.util").cwd.project() } })
end)
vim.keymap.set("n", "[finder]gd", function()
  require("thetto").start("git/diff", { opts = { cwd = require("thetto.util").cwd.project() } })
end)
vim.keymap.set("n", "[finder]gr", function()
  require("thetto").start(
    "git/diff",
    { opts = { cwd = require("thetto.util").cwd.project() }, source_opts = { expr = "%:p" } }
  )
end)
vim.keymap.set("n", "[finder]G", function()
  require("thetto").start("file/grep", {
    opts = {
      cwd = require("thetto.util").cwd.project(),
      debounce_ms = 100,
      filters = { "interactive", "substring", "-substring", "substring:path:relative", "-substring:path:relative" },
    },
  })
end)
vim.keymap.set(
  "n",
  "[finder]gL",
  [[<Cmd>lua require("thetto").start("file/grep", {opts = {debounce_ms = 100, filters = {"interactive", "substring", "-substring", "substring:path:relative", "-substring:path:relative"}}})<CR>]]
)
vim.keymap.set("n", "[file]f", [[<Cmd>lua require("thetto").start("file/alter")<CR>]])
vim.keymap.set("n", "[file]l", [[<Cmd>lua require("thetto").start("file/alter", {opts = {action = "tab_open"}})<CR>]])
vim.keymap.set(
  "n",
  "[file]t",
  [[<Cmd>lua require("thetto").start("file/alter", {source_opts = {allow_new = true}})<CR>]]
)
vim.keymap.set(
  "n",
  "[finder]T",
  [[<Cmd>lua require("thetto").start("vim/buffer", {source_opts = {buftype = "terminal"}})<CR>]]
)
vim.keymap.set(
  "n",
  "[exec]cm",
  [[<Cmd>lua require("thetto").start("vim/execute", {opts = {display_limit = 1000, insert = false, offset = 1000}, source_opts = {cmd = "messages"}})<CR>]]
)
vim.keymap.set(
  "n",
  "[exec]cv",
  [[<Cmd>lua require("thetto").start("vim/execute", {source_opts = {cmd = "version"}})<CR>]]
)
vim.keymap.set("n", "[finder]J", [[<Cmd>lua require("thetto").start("vim/jump")<CR>]])
vim.keymap.set("n", "[finder]c", [[<Cmd>lua require("thetto").start("vim/command")<CR>]])
vim.keymap.set("n", "[finder]M", [[<Cmd>lua require("thetto").start("env/manual")<CR>]])
vim.keymap.set(
  "n",
  "[finder]q",
  [[<Cmd>lua require("thetto").start("cmd/jq", {opts = {filters = {"interactive", "substring", "-substring"}}})<CR>]]
)
vim.keymap.set("n", "[finder]gR", [[<Cmd>lua require("thetto").start("cmd/gron")<CR>]])
vim.keymap.set(
  "n",
  "[finder]jl",
  [[<Cmd>lua require("thetto").start("vim/jump", {source_opts = {per_file = true}})<CR>]]
)
vim.keymap.set("n", "[finder]z", [[<Cmd>lua require("thetto").start("cmd/zsh/history")<CR>]])
vim.keymap.set("n", "[finder]Q", [[<Cmd>lua require("thetto").start("vim/history/command")<CR>]])
vim.keymap.set(
  "n",
  "[finder]I",
  [[<Cmd>lua require("thetto").start("github/issue", {source_opts = {assignee = "me"}})<CR>]]
)
vim.keymap.set("n", "[finder]gP", [[<Cmd>lua require("thetto").start("github/pull_request")<CR>]])
vim.keymap.set(
  "n",
  "[finder]to",
  [[<Cmd>lua require("thetto").start("test", {opts = {action = "execute", auto = "preview"}})<CR>]]
)
vim.keymap.set(
  "n",
  "[finder]ts",
  [[<Cmd>lua require("thetto").start("test", {source_opts = {scoped = true}, opts = {action = "execute", auto = "preview"}})<CR>]]
)
vim.keymap.set(
  "n",
  "[finder]b",
  [[<Cmd>lua require("thetto").start("url/bookmark", {opts = {action = "browser_open"}})<CR>]]
)

-- custom source
vim.keymap.set("n", "[finder]p", [[<Cmd>lua require("thetto").start("plugin")<CR>]])
vim.keymap.set(
  "n",
  "[finder]e",
  [[<Cmd>lua require("thetto").start("emoji", {opts = {action = "append"}, action_opts = {key = "emoji"}})<CR>]]
)
vim.keymap.set("n", "[finder]gp", [[<Cmd>lua require("thetto").start("go/package")<CR>]])
vim.keymap.set("n", "[finder]a", [[<Cmd>lua require("thetto").start("aliaser")<CR>]])
vim.keymap.set("n", "[finder]d", [[<Cmd>lua require("thetto").start("diagnostic")<CR>]])
vim.keymap.set("n", "[finder]w", [[<Cmd>lua require("thetto").start("lsp_adapter/workspace_symbol")<CR>]])
vim.keymap.set("n", "[exec]gr", [[<Cmd>lua require("thetto").start("lsp_adapter/text_document_references")<CR>]])

-- custom action
vim.keymap.set(
  "n",
  "[finder];",
  [[<Cmd>lua require("thetto").start("vim/filetype", {opts = {action = "open_scratch"}})<CR>]]
)
