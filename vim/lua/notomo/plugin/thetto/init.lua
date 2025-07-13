local thetto = require("thetto")

local kinds = {}
local register_kind = function(kind_name, fields)
  kinds[kind_name] = function()
    return require("thetto.util.kind").by_name(kind_name, fields, { use_registered = false })
  end
end

local sources = {}

local register_source = function(source_name, fields)
  sources[source_name] = function()
    if type(fields) == "function" then
      fields = fields()
    end
    return require("thetto.util.source").by_name(source_name, fields, { use_registered = false })
  end
end

local register_source_alias = function(alias_name, source_name, fields)
  sources[alias_name] = function()
    if type(fields) == "function" then
      fields = fields()
    end
    return require("thetto.util.source").by_name(source_name, fields, { use_registered = false })
  end
end

local ignore_patterns = {}
vim.list_extend(ignore_patterns, vim.g.notomo_thetto_ignore_pattenrs or {})

register_kind("file", {
  action_treesitter_search = function(items)
    local paths = vim
      .iter(items)
      :map(function(item)
        return item.path
      end)
      :totable()
    return require("thetto.util.source").start_by_name("listdefined_search", {
      opts = { paths = paths },
    })
  end,
  action_unionbuf = function(items, action_ctx)
    local entries = vim.iter(items):map(action_ctx.opts.convert):totable()
    require("unionbuf").open(entries)
  end,
  opts = {
    unionbuf = {
      convert = function(item)
        if not item.row or not item.path then
          return nil
        end
        return {
          path = item.path,
          start_row = item.row - 1,
        }
      end,
    },
    preview = { ignore_patterns = ignore_patterns },
  },
})

register_kind("git/status", {
  opts = {
    preview = { ignore_patterns = ignore_patterns },
  },
})

register_source_alias("vim/buffer/terminal", "vim/buffer", {
  filter = require("thetto.util.source").filter(function(item)
    return vim.bo[item.bufnr].buftype == "terminal"
  end),
  highlight = require("thetto.util.highlight").columns({
    {
      group = "Comment",
      filter = function(item)
        return vim.endswith(item.value, ":zsh")
      end,
    },
  }),
})

register_source("vim/terminal_prompt", {
  opts = {
    row_offset = 2,
  },
})

register_kind("url", {
  opts = {
    open_browser = {
      open = function(url)
        require("notomo.lib.browser").open(url)
      end,
    },
  },
})

register_kind("vim/variable", {
  action_edit = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdbuf").split_open(vim.o.cmdwinheight, { line = "let " .. item.value })
    vim.cmd.normal({ args = { "$" }, bang = true })
  end,
  default_action = "edit",
})

register_kind("vim/option", {
  action_edit = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdbuf").split_open(vim.o.cmdwinheight, { line = "setlocal " .. item.value })
    vim.cmd.normal({ args = { "$" }, bang = true })
  end,
})

register_kind("vim/command", {
  action_open = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdbuf").split_open(vim.o.cmdwinheight, { line = item.value })
    vim.cmd.normal({ args = { "$" }, bang = true })
  end,
})

register_kind("github/repository", {
  action_temporary_clone = function(items)
    local item = items[1]
    if not item then
      return
    end
    local dir = vim.fn.expand("~/workspace/memo/tmp")
    vim.fn.mkdir(dir, "p")
    require("notomo.lib.job").run({ "gh", "repo", "clone", item.value }, { cwd = dir })
  end,
})

register_source("github/project", {
  actions = {
    action_list_children = function(items)
      local item = items[1]
      if not item then
        return
      end
      return require("thetto").start("github/project/item", {
        opts = {
          project_url = item.url,
          query = vim.g.notomo_gh_project_item_query,
        },
      })
    end,
  },
})

register_source_alias("github/project/item_with_close", "github/project/item", {
  opts = {
    project_url = vim.g.notomo_gh_project_url,
    query = [[.[] | select((.fieldValues.nodes|any(.field.name == "Iteration")))]],
  },
})

register_source_alias("github/pull_request_review", "github/pull_request", {
  opts = {
    extra_args = { "--review-requested=@me" },
  },
})

register_source("github/pull_request", {
  modify_pipeline = require("thetto.util.pipeline").pass_through(),
  get_pattern = function()
    return ""
  end,
})

register_source("vim/filetype", {
  actions = {
    action_open_scratch = function(items)
      local item = items[1]
      if item == nil then
        return
      end
      local filetype = item.value
      local name = require("filetypext").detect({ filetype = filetype })[1]
      require("notomo.lib.edit").scratch(name, filetype)
    end,
    action_search = function(items)
      local item = items[1]
      if item == nil then
        return
      end
      local bufnr = vim.fn.bufadd(vim.fn.expand("$DOTFILES/vim/lua/notomo/plugin/runtimetable/filetype.lua"))
      vim.fn.bufload(bufnr)
      return require("thetto.util.source").start_by_name("vim/line", {
        can_resume = false,
        filter = require("thetto.util.source").filter(function(e)
          local pattern = ([["%s.lua"]]):format(vim.pesc(item.value))
          return e.value:find(pattern)
        end),
      }, {
        source_bufnr = bufnr,
        consumer_factory = require("thetto.util.consumer").immediate(),
      })
    end,
  },
})

local file_recursive, file_recursive_all, directory_recursive, directory_recursive_all, modify_path
if vim.fn.has("win32") == 0 then
  file_recursive = function(path, max_depth)
    return {
      "rg",
      "--follow",
      "--color=never",
      "--hidden",
      "--glob=!.git",
      "--max-depth=" .. max_depth,
      "--files",
      path,
    }
  end

  file_recursive_all = function(...)
    local cmd = file_recursive(...)
    table.insert(cmd, 2, "--no-ignore")
    return cmd
  end

  directory_recursive = function(path, max_depth)
    return {
      "fd",
      "--hidden",
      "--color=never",
      "--exclude",
      ".git",
      "-L",
      "--max-depth",
      max_depth,
      "-t",
      "d",
      ".",
      path,
    }
  end

  directory_recursive_all = function(...)
    local cmd = file_recursive(...)
    table.insert(cmd, 2, "--no-ignore")
    return cmd
  end

  modify_path = function(path)
    return path
  end
end

register_source("file/recursive", function()
  return {
    opts = { get_command = file_recursive },
    modify_pipeline = require("thetto.util.pipeline").list({
      require("thetto.util.filter").by_name("substring"),
      require("thetto.util.filter").by_name("substring", {
        opts = {
          inversed = true,
        },
      }),
      require("thetto.util.filter").by_name("regex"),
      require("thetto.util.filter").by_name("regex", {
        opts = {
          inversed = true,
        },
      }),
      require("thetto.util.sorter").by_name("path"),
    }),
  }
end)

sources["file/recursive/all"] = function()
  local source = require("thetto.util.source").by_name("file/recursive")
  source.opts.get_command = file_recursive_all
  return source
end

register_source("file/directory/recursive", function()
  return {
    opts = {
      get_command = directory_recursive,
      modify_path = modify_path,
    },
    modify_pipeline = require("thetto.util.pipeline").append({
      require("thetto.util.sorter").field_length_by_name("value"),
    }),
  }
end)

sources["directory/recursive/all"] = function()
  local source = require("thetto.util.source").by_name("directory/recursive")
  source.opts.get_command = directory_recursive_all
  return source
end

register_source("vim/line", function()
  return {
    modify_pipeline = require("thetto.util.pipeline").list({
      require("thetto.util.filter").by_name("regex"),
      require("thetto.util.filter").by_name("regex", {
        opts = {
          inversed = true,
        },
      }),
      require("thetto.util.filter").by_name("substring"),
      require("thetto.util.filter").by_name("substring", {
        opts = {
          inversed = true,
        },
      }),
    }),
  }
end)

local value_path_filters = function()
  return require("thetto.util.pipeline").list({
    require("thetto.util.filter").by_name("substring"),
    require("thetto.util.filter").by_name("substring", {
      opts = {
        inversed = true,
      },
    }),
    require("thetto.util.filter").relative_path("path", "substring"),
    require("thetto.util.filter").relative_path("path", "substring", {
      opts = {
        inversed = true,
      },
    }),
  })
end

register_source("vim/diagnostic", function()
  return {
    modify_pipeline = require("thetto.util.pipeline").list({
      require("thetto.util.filter").relative_path("path", "substring"),
      require("thetto.util.filter").relative_path("path", "substring", {
        opts = {
          inversed = true,
        },
      }),
    }),
  }
end)
register_source("vim/lsp/incoming_calls", function()
  return {
    modify_pipeline = value_path_filters(),
  }
end)
register_source("vim/lsp/outgoing_calls", function()
  return {
    modify_pipeline = value_path_filters(),
  }
end)

local ignored_symbol_kind = { "field", "property" }
register_source("vim/lsp/document_symbol", function()
  return {
    filter = require("thetto.util.source").filter(function(item)
      if vim.tbl_contains(ignored_symbol_kind, item.symbol_kind:lower()) then
        return false
      end
      if not item.value:find("%(") and item.value:find("%.") then
        return false
      end
      if item.value:find(" callback%.?.*$") then
        return false
      end
      return true
    end),
    modify_pipeline = require("thetto.util.pipeline").append({
      require("thetto.util.sorter").field_by_name("row", false),
    }),
  }
end)

register_source("file/grep", function()
  return {
    opts = {
      command = "rg",
      command_opts = {
        "--color=never",
        "--no-heading",
        "--smart-case",
        "--glob=!.git",
        "--hidden",
        "--line-number",
      },
      pattern_opt = "-e",
      recursive_opt = "",
      separator = "",
    },
    modify_pipeline = value_path_filters(),
  }
end)

local ignored_ctags_type = { "member", "package", "packageName", "anonMember", "constant" }
register_source("cmd/ctags", function()
  return {
    filter = require("thetto.util.source").filter(function(item)
      return not vim.tbl_contains(ignored_ctags_type, item.ctags_type)
    end),
    modify_pipeline = require("thetto.util.pipeline").list({
      require("thetto.util.sorter").field_by_name("row", false),
      require("thetto.util.filter").by_name("regex"),
      require("thetto.util.filter").by_name("regex", {
        opts = {
          inversed = true,
        },
      }),
    }),
  }
end)

register_source("file/bookmark", function()
  return {
    modify_pipeline = require("thetto.util.pipeline").append({
      require("thetto.util.sorter").field_by_merged({
        require("thetto.util.sorter").field_by_name("kind_name", true),
        require("thetto.util.sorter").field_length_by_name("value"),
      }),
    }),
    opts = {
      default_paths = {
        vim.fn.expand("$DOTFILES/vim/rc/local/local.vim"),
        "~/.local/.bashrc",
        "~/.bashrc",
        "~/.local/.bash_profile",
        "~/.bash_profile",
        "~/workspace/*",
        vim.fn.stdpath("cache") .. "/*",
        vim.fn.stdpath("config") .. "/*",
        vim.fn.stdpath("data") .. "/*",
        vim.fn.stdpath("state") .. "/*",
        vim.fn.stdpath("log") .. "/*",
      },
    },
  }
end)

register_source("file/alter", {
  opts = {
    pattern_groups = {
      { "%_test.go", "%.go" },
      { "%/spec/lua/%_spec.lua", "%/lua/%.lua" },
      { "%/test/lua/%_spec.lua", "%/lua/%.lua" },
      { "%.c", "%.h" },
      { "%.spec.tsx", "%.tsx" },
      { "%.spec.ts", "%.ts" },
      { "%_test.ts", "%.ts" },
      { "%.test.ts", "%.ts" },
    },
  },
})

local listdefined_names = {
  "keymap",
  "autocmd",
  "autocmd_group",
  "highlight",
  "command",
}
for _, name in ipairs(listdefined_names) do
  register_source_alias("listdefined/" .. name, "listdefined", {
    opts = {
      name = name,
    },
  })
end

local ignored_file_names = { "COMMIT_EDITMSG" }
register_source("file/mru", function()
  return {
    filter = require("thetto.util.source").filter(function(item)
      local file_name = vim.fs.basename(item.path)
      return not vim.tbl_contains(ignored_file_names, file_name)
    end),
  }
end)

register_source("cmd/zsh/history", function()
  return {
    modify_pipeline = require("thetto.util.pipeline").append({
      require("thetto.util.sorter").field_length_by_name("value"),
    }),
    cwd = require("thetto.util.cwd").upward({ "Makefile" }),
  }
end)

register_source_alias("vim/buffer_autocmd", "vim/autocmd", {
  opts = {
    buffer = true,
  },
})

register_source_alias("vim/modified_buffer", "vim/buffer", function()
  return {
    filter = require("thetto.util.source").filter(function(item)
      return vim.bo[item.bufnr].modified
    end),
  }
end)

register_source("github/issue", function()
  return {
    modify_pipeline = require("thetto.util.pipeline").list({
      require("thetto.util.filter").by_name("source_input"),
      require("thetto.util.filter").by_name("regex"),
      require("thetto.util.filter").by_name("regex", {
        opts = {
          inversed = true,
        },
      }),
    }),
  }
end)

register_source_alias("github/assigned_issue", "github/issue", {
  opts = {
    repo_with_owner = "",
    extra_args = { "--assignee=@me" },
  },
})

register_source_alias("github/authored_issue", "github/issue", {
  opts = {
    repo_with_owner = "",
    extra_args = { "--author=@me", "--sort=created" },
  },
})

local runner_actions = {
  opts = {
    execute = {
      driver = function(cmd, opts)
        require("cmdhndlr").run({
          name = "cmdhndlr/raw",
          working_dir = function()
            return opts.cwd
          end,
          layout = { type = "no" },
          runner_opts = { cmd = cmd },
          hooks = {
            success = require("cmdhndlr.util.hook").echo_success(),
            failure = require("cmdhndlr.util.hook").echo_failure(),
            pre_execute = require("cmdhndlr.util.hook").echo_cmd(),
          },
        })
      end,
    },
  },
  action_execute_reusable = function(items, action_ctx)
    return require("thetto.util.action").call(action_ctx.kind_name, "execute", items, {
      open = function() end,
      driver = function(cmd, opts)
        require("cmdhndlr").run({
          name = "cmdhndlr/raw",
          working_dir = function()
            return opts.cwd
          end,
          layout = { type = "tab_drop" },
          runner_opts = { cmd = cmd },
          hooks = {
            success = require("cmdhndlr.util.hook").echo_success(),
            failure = require("cmdhndlr.util.hook").echo_failure(),
            pre_execute = require("cmdhndlr.util.hook").echo_cmd(),
          },
          reuse_predicate = function(current_state, state)
            local same = current_state.full_name == state.full_name
              and current_state.working_dir_path == state.working_dir_path
              and vim.deep_equal(current_state.cmd, state.executed_cmd)
            return same
          end,
        })
      end,
    })
  end,
}
register_source("cmd/make/target", { actions = runner_actions })
register_source("cmd/npm/script", { actions = runner_actions })

register_source("cmd/aws/profile", function()
  return {
    actions = {
      opts = {
        yank = {
          convert = function(values)
            return vim
              .iter(values)
              :map(function(v)
                return ("AWS_PROFILE=%s "):format(v)
              end)
              :totable()
          end,
        },
      },
    },
  }
end)

thetto.set_default({
  sources = sources,
  kinds = kinds,
})

if not vim.tbl_contains(vim.v.argv, "--headless") then
  thetto.setup_store("file/mru")
end
vim.api.nvim_create_autocmd({ "User" }, {
  group = vim.api.nvim_create_augroup("notomo.thetto.kivi", {}),
  pattern = { "ThettoDirectoryOpened" },
  callback = function(args)
    local layout
    if args.data.bufnr then
      layout = { type = "hide" }
    end
    require("kivi").open({
      path = args.data.path,
      bufnr = args.data.bufnr,
      layout = layout,
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = vim.api.nvim_create_augroup("notomo.thetto.completion", {}),
  pattern = { "*" },
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype
    if vim.tbl_contains({ "thetto-inputter" }, filetype) then
      return
    end
    if not vim.bo[args.buf].modifiable then
      return
    end

    require("thetto.util.completion").enable({
      require("thetto.util.source").by_name("neosnippet"),
      require("thetto.util.source").by_name("vim/lsp/completion"),
      require("thetto.util.source").by_name("file/path"),
      require("thetto.util.source").by_name("vim/buffer_word"),
    }, {
      kind_priorities = {
        Field = 100001,
        Property = 100000,
        Directory = 10001,
        File = 10000,
      },
    })
  end,
})
