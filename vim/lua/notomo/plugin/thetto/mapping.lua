local action = function(action_name, execute_opts)
  return function()
    require("thetto.util.action").execute(action_name, {}, execute_opts)
  end
end

local action_with_fallback = function(action_names, execute_opts)
  return function()
    require("thetto.util.action").execute_with_fallback(action_names, {}, execute_opts)
  end
end

local action_key = function(prev, action_name)
  return function()
    vim.fn.feedkeys(prev, "mx")
    action(action_name)
  end
end

local thetto_starter = function(source_name, fields, opts)
  return function()
    require("thetto").start(require("thetto.util.source").by_name(source_name, fields), opts)
  end
end

local call_consumer = function(action_name, opts)
  return function()
    return require("thetto").call_consumer(action_name, opts)
  end
end

local call_consumer_key = function(prev, action_name, next)
  return ([[%s<Cmd>lua require("thetto").call_consumer(%q)<CR>%s]]):format(prev, action_name, next)
end

vim.keymap.set("n", "[finder]<CR>", function()
  require("thetto").resume()
end)
vim.keymap.set("n", "[finder]n", function()
  require("thetto").resume({
    item_cursor_factory = require("thetto.util.item_cursor").offset(1),
    consumer_factory = require("thetto.util.consumer").immediate(),
  })
end)
vim.keymap.set("n", "[finder]N", function()
  require("thetto").resume({
    item_cursor_factory = require("thetto.util.item_cursor").offset(-1),
    consumer_factory = require("thetto.util.consumer").immediate(),
  })
end)

local thetto_group = vim.api.nvim_create_augroup("thetto_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = thetto_group,
  pattern = { "thetto" },
  callback = function()
    vim.keymap.set("n", "<2-LeftMouse>", action(), { buffer = true, silent = true })
    vim.keymap.set("n", "<2-LeftMouse>", action(), { buffer = true, silent = true })
    vim.keymap.set("n", "<RightMouse>", [[<Nop>]], { buffer = true })
    vim.keymap.set("n", "<RightDrag>", [[<Nop>]], { buffer = true })
    vim.keymap.set("n", "<C-w>", call_consumer("quit"), { buffer = true })

    vim.keymap.set("n", "dd", call_consumer_key("", "move_to_input", "<Cmd>silent delete _<CR>"), { buffer = true })
    vim.keymap.set(
      "n",
      "cc",
      call_consumer_key("<ESC>", "move_to_input", "<Cmd>silent delete _<CR>"),
      { buffer = true }
    )

    vim.keymap.set("n", "i", call_consumer("move_to_input"), { buffer = true })
    vim.keymap.set("n", "I", call_consumer_key("", "move_to_input", "<Home>"), { buffer = true })
    vim.keymap.set("n", "a", call_consumer("move_to_input"), { buffer = true })
    vim.keymap.set("n", "A", call_consumer_key("", "move_to_input", "<End>"), { buffer = true })

    vim.keymap.set("n", "q", call_consumer("quit"), { buffer = true, nowait = true })
    vim.keymap.set("n", "M", call_consumer("increase_display_limit"), { buffer = true })

    vim.keymap.set("n", "<CR>", action(), { buffer = true })
    vim.keymap.set("n", "o", action("open"), { buffer = true })
    vim.keymap.set("n", "sv", action("vsplit_open"), { buffer = true })
    vim.keymap.set("n", "t<Space>", action("tab_open"), { buffer = true })
    vim.keymap.set("n", "fo", action("directory_open"), { buffer = true })
    vim.keymap.set("n", "fi", action("directory_tab_open"), { buffer = true })
    vim.keymap.set("n", "ff", action_with_fallback({ "list_children", "list_siblings" }), { buffer = true })
    vim.keymap.set("n", "F", action("list_parents"), { buffer = true })
    vim.keymap.set("n", "yy", action("yank"), { buffer = true })
    vim.keymap.set("n", "D", action("debug_print", { quit = false }), { buffer = true })
    vim.keymap.set("n", "rn", action("rename"), { buffer = true })
    vim.keymap.set("n", "O", action("search"), { buffer = true })

    vim.keymap.set("n", "rp", action("unionbuf"), { buffer = true })
    vim.keymap.set("n", "<Leader>rP", function()
      action("unionbuf", {
        action_opts = {
          convert = function(item)
            local bufnr = vim.fn.bufadd(item.path)
            vim.fn.bufload(bufnr)
            local s, e =
              require("notomo.lib.treesitter").get_expanded_row_range(bufnr, item.range.s.row, item.range.s.column)
            return {
              bufnr = bufnr,
              start_row = s,
              end_row = e,
            }
          end,
        },
      })
    end, { buffer = true })

    vim.keymap.set("n", "j", [[line('.') == line('$') ? 'gg' : 'j']], { buffer = true, expr = true, silent = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true, silent = true })

    vim.keymap.set("n", "<Tab>", thetto_starter("thetto/action"), { buffer = true })
    vim.keymap.set("n", "[finder]<CR>", function()
      require("thetto").resume({ offset = -1 })
    end, { buffer = true })
    vim.keymap.set("n", "[finder]n", function()
      require("thetto").resume({ offset = -1 })
    end, { buffer = true })
    vim.keymap.set("n", "[finder]N", function()
      require("thetto").resume({ offset = 1 })
    end, { buffer = true })

    vim.keymap.set("n", "sm", call_consumer_key("", "toggle_selection", "<Down>"), { buffer = true })
    vim.keymap.set("x", "sm", call_consumer_key("", "toggle_selection", "<ESC>"), { buffer = true })
    vim.keymap.set("n", "sa", call_consumer_key("", "toggle_all_selection", ""), { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = thetto_group,
  pattern = { "thetto-inputter" },
  callback = function()
    vim.keymap.set("n", "<CR>", action(), { buffer = true })
    vim.keymap.set("i", "<CR>", action_key(vim.keycode("<ESC>")), { buffer = true })
    vim.keymap.set("n", "o", action("open"), { buffer = true })
    vim.keymap.set("n", "sv", action("vsplit_open"), { buffer = true })
    vim.keymap.set("n", "t<Space>", action("tab_open"), { buffer = true })

    vim.keymap.set("i", "jq", call_consumer_key("", "quit", "<Cmd>stopinsert<CR>"), { buffer = true })
    vim.keymap.set("n", "q", call_consumer("quit"), { buffer = true })

    vim.keymap.set("n", "j", call_consumer("move_to_list"), { buffer = true })
    vim.keymap.set("n", "J", [[line('.') == line('$') ? 'gg' : 'j']], { buffer = true, silent = true, expr = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true })
    vim.keymap.set("n", "K", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true })

    vim.keymap.set("i", "<C-p>", call_consumer("recall_history", 1), { buffer = true })
    vim.keymap.set("i", "<C-n>", call_consumer("recall_history", -1), { buffer = true })

    vim.keymap.set("i", "<C-u>", function()
      require("notomo.lib.edit").delete_prev()
    end, { buffer = true })
  end,
})

local source_specific = {
  ["git/log"] = function(list_bufnr)
    vim.keymap.set("n", "yr", function()
      require("notomo.lib.edit").yank(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "yf", function()
      local short_commit_hash = require("thetto").get()[1].commit_hash
      local commit_hash = vim.fn.systemlist({ "git", "rev-parse", short_commit_hash })[1]
      require("notomo.lib.edit").yank(commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "yR", function()
      require("notomo.lib.github").yank_revision_with_repo(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "ym", function()
      require("notomo.lib.git").yank_commit_message(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "yu", function()
      require("notomo.lib.github").yank_commit_url(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "ch", action("checkout"), { buffer = list_bufnr })
    vim.keymap.set("n", "D", action("diff"), { buffer = list_bufnr })
    vim.keymap.set("n", "RS", action("reset"), { buffer = list_bufnr })
    vim.keymap.set("n", "F", action("fixup"), { buffer = list_bufnr })
    vim.keymap.set("n", "rw", action("reword"), { buffer = list_bufnr })
    vim.keymap.set("n", "I", action("rebase_interactively"), { buffer = list_bufnr })
  end,
  ["git/file_log"] = function(list_bufnr)
    vim.keymap.set("n", "yr", function()
      require("notomo.lib.edit").yank(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "yR", function()
      require("notomo.lib.github").yank_revision_with_repo(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "ym", function()
      require("notomo.lib.git").yank_commit_message(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "yu", function()
      require("notomo.lib.github").yank_commit_url(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
    vim.keymap.set("n", "ch", action("checkout"), { buffer = list_bufnr })
    vim.keymap.set("n", "D", action("diff"), { buffer = list_bufnr })
  end,
  ["git/change"] = function(list_bufnr)
    vim.keymap.set("n", "dd", action("compare"), { buffer = list_bufnr })
  end,
  ["git/branch"] = function(list_bufnr)
    vim.keymap.set("n", "C", action("create"), { buffer = list_bufnr })
    vim.keymap.set("n", "yr", function()
      require("notomo.lib.edit").yank(require("thetto").get()[1].commit_hash)
    end, { buffer = list_bufnr })
  end,
  ["git/status"] = function(list_bufnr)
    local action_without_message = function(action_name, execute_opts)
      return function()
        local items, metadata = require("thetto").get()
        local filtered = vim
          .iter(items)
          :filter(function(item)
            return item.kind_name ~= "git/status/message"
          end)
          :totable()
        require("thetto.util.action").execute(action_name, {}, execute_opts, function()
          return filtered, metadata
        end)
        require("misclib.visual_mode").leave()
      end
    end

    vim.keymap.set(
      { "n", "x" },
      "[git]a",
      action_without_message("toggle_stage", { quit = false }),
      { buffer = list_bufnr }
    )
    vim.keymap.set({ "n", "x" }, "U", action_without_message("discard", { quit = false }), { buffer = list_bufnr })
    vim.keymap.set({ "n", "x" }, "S", action("stash"), { buffer = list_bufnr })
    vim.keymap.set("n", "cc", action("commit"), { buffer = list_bufnr })
    vim.keymap.set("n", "ca", action("commit_amend"), { buffer = list_bufnr })
    vim.keymap.set("n", "dd", action("compare", { quit = false }), { buffer = list_bufnr })
    vim.keymap.set("n", "D", action("diff"), { buffer = list_bufnr })

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
    vim.keymap.set("n", "pop", action("pop"), { buffer = list_bufnr })
    vim.keymap.set("n", "AP", action("apply"), { buffer = list_bufnr })
  end,
  ["cmd/make/target"] = function(list_bufnr)
    vim.keymap.set("n", "P", action("dry_run"), { buffer = list_bufnr })
  end,
}
vim.api.nvim_create_autocmd({ "User" }, {
  group = thetto_group,
  pattern = { "ThettoOpened" },
  callback = function(args)
    local f = source_specific[args.data.source_name]
    if f then
      f(args.data.list_bufnr)
    end
  end,
})

vim.keymap.set("n", "[finder]R", thetto_starter("vim/runtimepath"))
vim.keymap.set("n", "<Space>usf", thetto_starter("file/recursive"))
vim.keymap.set("n", "[finder]f", thetto_starter("file/in_dir"))
vim.keymap.set("n", "[finder]h", thetto_starter("vim/help"))

vim.keymap.set("n", "[finder]l", thetto_starter("vim/line"))
vim.keymap.set("n", "[finder]L", function()
  local row_range, err = require("notomo.lib.treesitter").get_current_function_range()
  if err then
    error(err)
  end
  thetto_starter("vim/line", {
    opts = {
      start_row = row_range[1],
      end_row = row_range[2] + 1,
    },
  })()
end)

vim.keymap.set("n", "[finder]b", thetto_starter("url/bookmark"))
vim.keymap.set("n", "[finder]p", thetto_starter("plugin"))
vim.keymap.set("n", "[finder]e", thetto_starter("emoji"))
vim.keymap.set("n", "[finder]a", thetto_starter("aliaser"))
vim.keymap.set("n", "[finder]C", thetto_starter("cmdhndlr/runner"))
vim.keymap.set("n", "[finder]O", thetto_starter("vim/option"))
vim.keymap.set("n", "[finder]H", thetto_starter("vim/highlight_group"))
vim.keymap.set("n", "[finder]B", thetto_starter("vim/buffer"))
vim.keymap.set("n", "[finder]y", thetto_starter("file/bookmark"))
vim.keymap.set("n", "[finder]E", thetto_starter("env/variable"))
vim.keymap.set("n", "[finder]z", thetto_starter("cmd/zsh/history"))
vim.keymap.set("n", "[finder]J", thetto_starter("vim/jump"))
vim.keymap.set("n", "[finder]c", thetto_starter("vim/command"))
vim.keymap.set("n", "[finder]q", thetto_starter("cmd/jq"))
vim.keymap.set("n", "[finder]P", thetto_starter("cmd/procs"))
vim.keymap.set("n", "[finder]A", thetto_starter("vim/autocmd"))
vim.keymap.set("n", "[finder]s", thetto_starter("thetto/source"))
vim.keymap.set("n", "[finder]m", thetto_starter("listdefined/keymap"))
vim.keymap.set("n", "[finder]o", thetto_starter("cmd/ctags"))
vim.keymap.set("n", "[finder]S", thetto_starter("vim/substitute"))
vim.keymap.set("x", "[finder]s", thetto_starter("vim/substitute"))
vim.keymap.set("n", "[finder];", thetto_starter("vim/filetype", { actions = { default_action = "open_scratch" } }))

vim.keymap.set(
  "n",
  "[exec]gr",
  thetto_starter("vim/lsp/references", {
    consumer_opts = {
      ui = {
        insert = false,
      },
    },
  })
)

vim.keymap.set("n", "[finder]gP", thetto_starter("github/pull_request"))
vim.keymap.set("n", "[finder]gp", function()
  thetto_starter("github/pull_request", { opts = { url = vim.fn.expand("<cWORD>") } })()
end)
vim.keymap.set("n", "[finder]gi", function()
  thetto_starter("github/issue", { opts = { url = vim.fn.expand("<cWORD>") } })()
end)
vim.keymap.set("n", "[finder]gI", function()
  thetto_starter("github/project/item", {
    opts = {
      project_url = vim.g.notomo_gh_project_url,
      query = vim.g.notomo_gh_project_item_query,
    },
  })()
end)

vim.keymap.set("n", "[file]f", function()
  require("thetto").start(require("thetto.util.source").by_name("file/alter"), {
    consumer_factory = require("thetto.util.consumer").immediate(),
  })
end)

vim.keymap.set("n", "[file]l", function()
  require("thetto").start(require("thetto.util.source").by_name("file/alter"), {
    actions = { default_action = "tab_open" },
    consumer_factory = require("thetto.util.consumer").immediate(),
  })
end)

vim.keymap.set("n", "[file]t", function()
  require("thetto").start(require("thetto.util.source").by_name("file/alter"), {
    opts = {
      allow_new = true,
    },
    consumer_factory = require("thetto.util.consumer").immediate(),
  })
end)

vim.keymap.set("n", "[finder]T", function()
  require("thetto").start(require("thetto.util.source").by_name("vim/buffer", {
    modify_pipeline = require("thetto.util.pipeline").prepend({
      require("thetto.util.filter").item(function(item)
        return vim.bo[item.bufnr].buftype == "terminal"
      end),
    }),
  }))
end)
vim.keymap.set("n", "[exec]cv", thetto_starter("vim/execute", { opts = { cmd = "version" } }))

vim.keymap.set("n", "<Space>ur", function()
  require("thetto").start(require("thetto.util.source").by_name("file/mru", {
    cwd = require("thetto.util.cwd").project(),
  }))
end)

vim.keymap.set("n", "<Space>usd", thetto_starter("file/directory/recursive"))
vim.keymap.set("n", "[finder]r", function()
  require("thetto").start(require("thetto.util.source").by_name("file/directory/recursive", {
    cwd = require("thetto.util.cwd").project(),
  }))
end)

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
  require("thetto").start(require("thetto.util.source").by_name("file/recursive", {
    cwd = require("thetto.util.cwd").project(),
    opts = ls_opts,
  }))
end)
vim.keymap.set(
  "n",
  "[finder]v",
  thetto_starter("file/recursive", {
    cwd = "$DOTFILES",
    source_opts = ls_opts,
  })
)

vim.keymap.set("n", "[keyword]gg", function()
  thetto_starter("file/grep", {
    cwd = require("thetto.util.cwd").project(),
    get_pattern = function()
      return vim.fn.expand("<cword>")
    end,
  })()
end)
vim.keymap.set("n", "[finder]gl", thetto_starter("file/grep"), { silent = true })
vim.keymap.set("n", "[finder]G", function()
  require("thetto").start(
    require("thetto.util.source").by_name("file/grep", {
      cwd = require("thetto.util.cwd").project(),
    }),
    {
      pipeline_stages_factory = require("thetto.util.pipeline").merge({
        require("thetto.util.pipeline").apply_source(),
        require("thetto.util.pipeline").prepend({
          require("thetto.util.filter").by_name("source_input"),
        }),
      }),
    }
  )
end)
vim.keymap.set("n", "[finder]gL", function()
  require("thetto").start(require("thetto.util.source").by_name("file/grep"), {
    pipeline_stages_factory = require("thetto.util.pipeline").merge({
      require("thetto.util.pipeline").apply_source(),
      require("thetto.util.pipeline").prepend({
        require("thetto.util.filter").by_name("source_input"),
      }),
    }),
  })
end)
vim.keymap.set(
  "n",
  "[finder]go",
  thetto_starter("file/directory/recursive", { cwd = "$GOPATH/src", opts = { max_depth = 3 } })
)

vim.keymap.set("n", "[keyword]n", function()
  vim.lsp.buf.clear_references()
  vim.lsp.buf.document_highlight()

  local current_row = vim.fn.line(".")
  local path = vim.api.nvim_buf_get_name(0)
  require("thetto").start(require("thetto.util.source").by_name("vim/lsp/references", {
    item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
      return item.path == path and item.row == current_row
    end),
    actions = {
      default_action = "open",
    },
    consumer_opts = {
      ui = {
        insert = false,
      },
    },
  }))
end)

local get_paths = function(cwd)
  local regex = vim.regex([[\v(_spec.lua|_test.go)$]])
  return vim
    .iter(vim.fs.find(function(name)
      return regex:match_str(name) ~= nil
    end, {
      type = "file",
      limit = math.huge,
      path = cwd,
    }))
    :filter(function(path)
      return path:find("%.shared") == nil
    end)
    :totable()
end
vim.keymap.set(
  "n",
  "[finder]tl",
  thetto_starter("test", {
    opts = {
      get_paths = get_paths,
    },
  })
)
vim.keymap.set("n", "[finder]tL", function()
  thetto_starter("test", {
    cwd = require("thetto.util.cwd").project(),
    opts = {
      get_paths = get_paths,
    },
  })()
end)
vim.keymap.set("n", "[finder]to", thetto_starter("test"))

vim.keymap.set("n", "[exec],", function()
  if require("cmdhndlr").get("normal_runner/make/make").working_dir_marker() then
    require("thetto.util.source").start_by_name("cmd/make/target")
    return
  end
  require("thetto.util.source").start_by_name("cmd/npm/script", {
    cwd = require("thetto.util.cwd").project(),
  })
end)

vim.keymap.set("n", "[finder]d", thetto_starter("vim/diagnostic"))
vim.keymap.set("n", "[finder]D", function()
  thetto_starter("vim/diagnostic", {
    cwd = require("thetto.util.cwd").project(),
    opts = { args = {} },
  })()
end)
vim.keymap.set("n", "<Space>qn", function()
  local current_row = vim.fn.line(".")
  local path = vim.api.nvim_buf_get_name(0)
  vim.cmd.normal({ args = { "m'" }, bang = true })
  require("thetto").start(
    require("thetto.util.source").by_name("vim/diagnostic", {
      actions = {
        default_action = "open",
      },
      can_resume = false,
    }),
    {
      item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
        return item.path == path and item.row > current_row
      end),
      consumer_factory = require("thetto.util.consumer").immediate(),
    }
  )
end)
vim.keymap.set("n", "<Space>qp", function()
  local current_row = vim.fn.line(".")
  local path = vim.api.nvim_buf_get_name(0)
  vim.cmd.normal({ args = { "m'" }, bang = true })
  require("thetto").start(
    require("thetto.util.source").by_name("vim/diagnostic", {
      actions = {
        default_action = "open",
      },
      can_resume = false,
      modify_pipeline = require("thetto.util.pipeline").append({
        require("thetto.util.sorter").field_by_name("row", true),
      }),
    }),
    {
      item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
        return item.path == path and item.row < current_row
      end),
      consumer_factory = require("thetto.util.consumer").immediate(),
    }
  )
end)

vim.keymap.set("n", "[git]dl", thetto_starter("git/deleted_file"))
vim.keymap.set("n", "[finder]gt", thetto_starter("git/tag"))
vim.keymap.set("n", "[finder]gT", thetto_starter("git/tag", { opts = { merged = true } }))
vim.keymap.set("n", "[git]ll", thetto_starter("git/log"))
vim.keymap.set("n", "[git]fl", thetto_starter("git/file_log"))
vim.keymap.set("n", "[finder]gd", thetto_starter("git/diff"))
vim.keymap.set("n", "[finder]gr", thetto_starter("git/diff", { opts = { expr = "%:p" } }))
vim.keymap.set("n", "[git]xl", thetto_starter("git/stash"))
vim.keymap.set("n", "[git]xs", function()
  require("thetto").start(require("thetto.util.source").by_name("git/stash"), {
    consumer_factory = require("thetto.util.consumer").immediate({ action_name = "create" }),
  })
end)

vim.keymap.set("n", "[finder]ga", function()
  require("thetto").start(require("thetto.util.source").by_name("git/branch", {
    modify_pipeline = require("thetto.util.pipeline").append({
      require("thetto.util.sorter").field_length_by_name("value"),
    }),
    consumer_opts = {
      ui = {
        insert = true,
      },
    },
  }))
end)

vim.keymap.set("n", "[finder]gA", function()
  require("thetto").start(require("thetto.util.source").by_name("git/branch", {
    actions = {
      opts = {
        checkout = { track = true },
      },
    },
    opts = { all = true },
    modify_pipeline = require("thetto.util.pipeline").append({
      require("thetto.util.sorter").field_length_by_name("value"),
    }),
    consumer_opts = {
      ui = {
        insert = true,
      },
    },
  }))
end)

vim.keymap.set("n", "[git]b", function()
  require("thetto").start(require("thetto.util.source").by_name("git/branch"), {
    item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
      return item.is_current_branch
    end),
  })
end)

vim.keymap.set("n", "[git]s", function()
  require("thetto").start(require("thetto.util.source").by_name("git/status"), {
    item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
      return item.path ~= nil
    end),
  })
end)
vim.keymap.set("n", "[git]B", function()
  local row = vim.fn.line(".")
  require("thetto").start(
    require("thetto.util.source").by_name("git/blame", {
      consumer_opts = {
        ui = {
          insert = false,
          display_limit = row + 100,
        },
      },
    }),
    {
      item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
        return item.row == row
      end),
    }
  )
end)

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
  local original_cursor = vim.api.nvim_win_get_cursor(0)
  require("thetto.util.git").compare(git_root, path, "HEAD", path):next(function()
    vim.api.nvim_win_set_cursor(0, original_cursor)
  end)
end)

vim.keymap.set("n", "[git]j", function()
  if vim.wo.diff then
    vim.api.nvim_feedkeys(vim.keycode("]c"), "m", true)
    return
  end

  local current_row = vim.fn.line(".")
  local path = vim.api.nvim_buf_get_name(0)
  vim.cmd.normal({ args = { "m'" }, bang = true })
  thetto_starter("git/diff", {
    can_resume = false,
    opts = { expr = path },
  }, {
    item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
      return item.path == path and item.row > current_row
    end),
    consumer_factory = require("thetto.util.consumer").immediate({ action_name = "open" }),
  })()
end)

vim.keymap.set("n", "[git]k", function()
  if vim.wo.diff then
    vim.api.nvim_feedkeys(vim.keycode("[c"), "m", true)
    return
  end

  local current_row = vim.fn.line(".")
  local path = vim.api.nvim_buf_get_name(0)
  vim.cmd.normal({ args = { "m'" }, bang = true })
  thetto_starter("git/diff", {
    can_resume = false,
    opts = { expr = path },
    modify_pipeline = require("thetto.util.pipeline").append({
      require("thetto.util.sorter").field_by_name("row", true),
    }),
  }, {
    item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
      return item.path == path and item.row < current_row
    end),
    consumer_factory = require("thetto.util.consumer").immediate({ action_name = "open" }),
  })()
end)
