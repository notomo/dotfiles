local source_config = {}
local source_actions = {}
local kind_actions = {}

local ignore_patterns = {}
vim.list_extend(ignore_patterns, vim.g.notomo_thetto_ignore_pattenrs or {})

kind_actions["file"] = {
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
}
kind_actions["git/status"] = {
  opts = {
    preview = { ignore_patterns = ignore_patterns },
  },
}

kind_actions["vim/variable"] = {
  action_edit = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdbuf").split_open(vim.o.cmdwinheight, { line = "let " .. item.value })
    vim.cmd.normal({ args = { "$" }, bang = true })
  end,
  default_action = "edit",
}

kind_actions["vim/option"] = {
  action_edit = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdbuf").split_open(vim.o.cmdwinheight, { line = "setlocal " .. item.value })
    vim.cmd.normal({ args = { "$" }, bang = true })
  end,
}

kind_actions["vim/command"] = {
  action_open = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    require("cmdbuf").split_open(vim.o.cmdwinheight, { line = item.value })
    vim.cmd.normal({ args = { "$" }, bang = true })
  end,
}

local url_actions = {
  action_open_browser = function(items)
    for _, item in ipairs(items) do
      vim.cmd.OpenBrowser(item.url)
    end
  end,
}
kind_actions["url"] = url_actions
source_actions["url/bookmark"] = url_actions

kind_actions["github/repository"] = {
  action_temporary_clone = function(items)
    local item = items[1]
    if not item then
      return
    end
    local dir = vim.fn.expand("~/workspace/memo/tmp")
    vim.fn.mkdir(dir, "p")
    require("notomo.lib.job").run({ "gh", "repo", "clone", item.value }, { cwd = dir })
  end,
}

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
source_config["file/recursive"] = {
  opts = { get_command = file_recursive },
  sorters = { "length" },
  filters = {
    "regex",
    "-regex",
  },
}
source_config["file/directory/recursive"] = {
  opts = { get_command = directory_recursive, modify_path = modify_path },
  sorters = { "length" },
}

source_config["line"] = {
  filters = { "regex", "-regex", "substring", "-substring" },
}

source_config["vim/diagnostic"] = {
  filters = {
    "substring",
    "-substring",
    "substring:path:relative",
    "-substring:path:relative",
  },
}

source_config["file/grep"] = {
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
  filters = { "substring", "-substring", "substring:path:relative", "-substring:path:relative" },
}

source_config["vim/lsp/references"] = {
  filters = {
    "substring:path:relative",
    "-substring:path:relative",
  },
}
source_config["vim/lsp/workspace_symbol"] = {
  filters = {
    "interactive",
    "substring",
    "-substring",
    "substring:kind",
    "substring:path:relative",
    "-substring:path:relative",
  },
}
source_config["vim/lsp/incoming_calls"] = {
  filters = { "substring", "-substring", "substring:path:relative", "-substring:path:relative" },
}
source_config["vim/lsp/outgoing_calls"] = {
  filters = { "substring", "-substring", "substring:path:relative", "-substring:path:relative" },
}

source_config["file/bookmark"] = {
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

source_config["cmd/ctags"] = {
  opts = { ignore = { "member", "package", "packageName", "anonMember", "constant" } },
  filters = { "regex", "-regex" },
}

source_config["file/alter"] = {
  opts = {
    pattern_groups = {
      { "%_test.go", "%.go" },
      { "%_test.ts", "%.ts" },
      { "%/spec/lua/%_spec.lua", "%/lua/%.lua" },
      { "%/test/lua/%_spec.lua", "%/lua/%.lua" },
      { "%.c", "%.h" },
    },
  },
}

source_config["cmd/zsh/history"] = {
  sorters = { "length" },
  global_opts = { cwd = require("thetto.util.cwd").upward({ "Makefile" }) },
}

source_config["github/assigned_issue"] = {
  alias_to = "github/issue",
  opts = {
    repo_with_owner = "",
    extra_args = { "--assignee=@me" },
  },
}

source_config["go/bin"] = {
  alias_to = "file/recursive",
  global_opts = {
    cwd = (vim.env.GOBIN or vim.env.GOPATH) .. "/bin",
    action = "go_install_latest",
    auto = "",
  },
}
source_actions["file/recursive"] = {
  -- HACK
  action_go_install_latest = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    local package_path = require("notomo.lib.go").to_package(item.path)
    if not package_path then
      return nil, "no package_path: " .. item.path
    end
    require("notomo.lib.job").run({ "go", "install", package_path .. "@latest" })
  end,
}

source_config["vim/buffer_autocmd"] = {
  alias_to = "vim/autocmd",
  opts = {
    buffer = 0,
  },
}

source_actions["vim/filetype"] = {
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
}

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
source_actions["cmd/make/target"] = runner_actions
source_actions["cmd/npm/script"] = runner_actions

local listdefined_names = {
  "keymap",
  "autocmd",
  "autocmd_group",
  "highlight",
}
for _, name in ipairs(listdefined_names) do
  source_config["listdefined/" .. name] = {
    alias_to = "listdefined",
    opts = {
      name = name,
    },
  }
end

require("thetto").setup({
  global_opts = {
    display_limit = 500,
  },
  filters = {
    "substring",
    "-substring",
  },
  source = source_config,
  source_actions = source_actions,
  kind_actions = kind_actions,
})

require("thetto").setup_store("file/mru")

-- TODO move to setup
require("thetto.handler.kind.file.directory").after = function(path, is_preview)
  local bufnr, layout
  if is_preview then
    bufnr = vim.api.nvim_create_buf(false, true)
    layout = { type = "hide" }
  end
  require("kivi").open({ path = path, bufnr = bufnr, layout = layout })
  return bufnr
end
