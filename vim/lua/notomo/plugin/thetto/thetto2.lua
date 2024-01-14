local register_kind = function(kind_name, fields)
  local kind = require("thetto2.util.kind").by_name(kind_name, fields, { use_registered = false })
  require("thetto2").register_kind(kind_name, kind)
end

local register_source = function(source_name, fields)
  local source = require("thetto2.util.source").by_name(source_name, fields, { use_registered = false })
  require("thetto2").register_source(source_name, source)
end

local register_source_alias = function(alias_name, source_name, fields)
  local source = require("thetto2.util.source").by_name(source_name, fields, { use_registered = false })
  require("thetto2").register_source(alias_name, source)
end

local ignore_patterns = {}
vim.list_extend(ignore_patterns, vim.g.notomo_thetto_ignore_pattenrs or {})

register_kind("file", {
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
        source_opts = {
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
      return require("thetto").start("line", {
        opts = {
          input_lines = { ([["%s.lua"]]):format(item.value) },
          immediately = true,
          insert = false,
          can_resume = false,
        },
        source_opts = { bufnr = bufnr },
      })
    end,
  },
})

local file_recursive, directory_recursive, modify_path
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
  modify_path = function(path)
    return path
  end
end

register_source("file/recursive", {
  opts = { get_command = file_recursive },
  modify_pipeline = require("thetto2.util.pipeline").list({
    require("thetto2.util.filter").by_name("regex"),
    require("thetto2.util.filter").by_name("regex", {
      opts = {
        inversed = true,
      },
    }),
    require("thetto2.util.sorter").field_length_by_name("value"),
  }),
})

register_source("file/directory/recursive", {
  opts = {
    get_command = directory_recursive,
    modify_path = modify_path,
  },
  modify_pipeline = require("thetto2.util.pipeline").append({
    require("thetto2.util.sorter").field_length_by_name("value"),
  }),
})

register_source("line", {
  modify_pipeline = require("thetto2.util.pipeline").list({
    require("thetto2.util.filter").by_name("regex"),
    require("thetto2.util.filter").by_name("regex", {
      opts = {
        inversed = true,
      },
    }),
    require("thetto2.util.filter").by_name("substring"),
    require("thetto2.util.filter").by_name("substring", {
      opts = {
        inversed = true,
      },
    }),
  }),
})

-- TODO: relative path
local relative_path_filter = function(name, raw_fields)
  local default = {}
  local fields = vim.tbl_deep_extend("force", default, raw_fields or {})
  return require("thetto2.util.filter").by_name(name, fields)
end

local value_path_filters = require("thetto2.util.pipeline").list({
  require("thetto2.util.filter").by_name("substring"),
  require("thetto2.util.filter").by_name("substring", {
    opts = {
      inversed = true,
    },
  }),
  relative_path_filter("substring"),
  relative_path_filter("substring", {
    opts = {
      inversed = true,
    },
  }),
})

local path_filters = require("thetto2.util.pipeline").list({
  relative_path_filter("substring"),
  relative_path_filter("substring", {
    opts = {
      inversed = true,
    },
  }),
})

register_source("vim/lsp/references", {
  modify_pipeline = path_filters,
})
register_source("vim/diagnostic", {
  modify_pipeline = value_path_filters,
})
register_source("vim/lsp/incoming_calls", {
  modify_pipeline = value_path_filters,
})
register_source("vim/lsp/outgoing_calls", {
  modify_pipeline = value_path_filters,
})

local ignored_symbol_kind = { "variable", "field" }
register_source("vim/lsp/document_symbol", {
  modify_pipeline = require("thetto2.util.pipeline").prepend({
    require("thetto2.util.filter").item(function(item)
      return not vim.tbl_contains(ignored_symbol_kind, item.symbol_kind:lower())
    end),
  }),
})

register_source("file/grep", {
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
  modify_pipeline = value_path_filters,
})

local ignored_ctags_type = { "member", "package", "packageName", "anonMember", "constant" }
register_source("cmd/ctags", {
  modify_pipeline = require("thetto2.util.pipeline").list({
    require("thetto2.util.filter").item(function(item)
      return not vim.tbl_contains(ignored_ctags_type, item.ctags_type)
    end),
    require("thetto2.util.filter").by_name("regex"),
    require("thetto2.util.filter").by_name("regex", {
      opts = {
        inversed = true,
      },
    }),
  }),
})

register_source("file/bookmark", {
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
})

register_source("file/alter", {
  opts = {
    pattern_groups = {
      { "%_test.go", "%.go" },
      { "%_test.ts", "%.ts" },
      { "%/spec/lua/%_spec.lua", "%/lua/%.lua" },
      { "%/test/lua/%_spec.lua", "%/lua/%.lua" },
      { "%.c", "%.h" },
      { "%.spec.ts", "%.ts" },
      { "%.spec.tsx", "%.tsx" },
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
register_source("file/mru", {
  modify_pipeline = require("thetto2.util.pipeline").prepend({
    require("thetto2.util.filter").item(function(item)
      local file_name = vim.fs.basename(item.path)
      return not vim.tbl_contains(ignored_file_names, file_name)
    end),
  }),
})

register_source("cmd/zsh/history", {
  modify_pipeline = require("thetto2.util.pipeline").append({
    require("thetto2.util.sorter").field_length_by_name("value"),
  }),
  cwd = require("thetto2.util.cwd").upward({ "Makefile" }),
})

register_source_alias("vim/buffer_autocmd", "vim/autocmd", {
  opts = {
    buffer = 0,
  },
})

register_source_alias("vim/modified_buffer", "vim/buffer", {
  modify_pipeline = require("thetto2.util.pipeline").prepend({
    require("thetto2.util.filter").item(function(item)
      return vim.bo[item.bufnr].modified
    end),
  }),
})

register_source("github/issue", {
  modify_pipeline = require("thetto2.util.pipeline").list({
    require("thetto2.util.filter").by_name("source_input"),
    require("thetto2.util.filter").by_name("regex"),
    require("thetto2.util.filter").by_name("regex", {
      opts = {
        inversed = true,
      },
    }),
  }),
})

register_kind("github/issue", {
  action_edit_body = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("notomo.lib.github").edit_issue(item.url, "body")
  end,
  action_edit_title = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("notomo.lib.github").edit_issue(item.url, "title")
  end,
})

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
        })
      end,
    },
  },
}
register_source("cmd/make/target", { actions = runner_actions })
register_source("cmd/npm/script", { actions = runner_actions })

require("thetto2").setup_store("file/mru")

vim.api.nvim_create_autocmd({ "User" }, {
  group = vim.api.nvim_create_augroup("notomo_thetto_to_kivi", {}),
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
