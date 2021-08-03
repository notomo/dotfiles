vim.cmd([[
highlight! ThettoColorLabelLua guibg=#7098e6
highlight! ThettoColorLabelVim guibg=#33aa77
highlight! ThettoColorLabelGo guibg=#70ffe6
highlight! ThettoColorLabelPythonBlue guibg=#3333dd
highlight! ThettoColorLabelPythonYellow guibg=#fedf81
highlight! ThettoColorLabelDir guibg=#a9dd9d
]])

local colors = {
  {pattern = ".lua$", chunks = {{" ", "ThettoColorLabelLua"}}},
  {pattern = ".go$", chunks = {{" ", "ThettoColorLabelGo"}}},
  {pattern = ".vim$", chunks = {{" ", "ThettoColorLabelVim"}}},
  {
    pattern = ".py$",
    chunks = {{" ", "ThettoColorLabelPythonYellow"}, {" ", "ThettoColorLabelPythonBlue"}},
  },
  {pattern = "/$", chunks = {{" ", "ThettoColorLabelDir"}}},
  {always = true, pattern = "", chunks = {{" ", "ThettoColorLabelOthers"}}},
}

local file_recursive, directory_recursive
if vim.fn.has("win32") == 0 then
  file_recursive = function(path, max_depth)
    return {
      "pt",
      "--follow",
      "--nocolor",
      "--nogroup",
      "--hidden",
      "--ignore=.git",
      "--ignore=.mypy_cache",
      "--ignore=node_modules",
      "--ignore=__pycache__",
      "--ignore=.DS_Store",
      "--depth=" .. max_depth,
      "-g=",
      path,
    }
  end

  local ignore_dirs = {".git", "node_modules", ".mypy_cache"}
  local cmds = {}
  for _, name in ipairs(ignore_dirs) do
    vim.list_extend(cmds, {"-type", "d", "-name", name, "-prune", "-o"})
  end
  vim.list_extend(cmds, {"-type", "d", "-print"})
  directory_recursive = function(path, max_depth)
    local cmd = {"find", "-L", path, "-maxdepth", max_depth}
    vim.list_extend(cmd, cmds)
    return cmd
  end
end

local brwoser_open = function(_, items)
  for _, item in ipairs(items) do
    vim.cmd("OpenBrowser " .. item.url)
  end
end

-- TODO move to setup
require("thetto.handler.kind.file.directory").after = function(path)
  require("kivi").open({path = path})
end

require("thetto").setup({
  store = {["file/mru"] = {opts = {ignore_pattern = "\\v(^(gina|thetto|term|kivi)://)"}}},

  kind_actions = {

    ["git/branch"] = {
      action_tab_open = function(_, items)
        for _, item in ipairs(items) do
          local cmd = ("Gina show %s:%%:p --opener=tabedit"):format(item.value)
          vim.cmd(cmd)
        end
      end,
      action_compare = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        local cmd = ("Gina compare %s:"):format(item.value)
        vim.cmd(cmd)
      end,
      action_diff = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        local cmd = ("Gina diff %s:"):format(item.value)
        vim.cmd(cmd)
      end,
    },

    file = {
      action_qfreplace = function(_, items)
        local qflist = {}
        for _, item in ipairs(items) do
          if item.row == nil or item.path == nil then
            goto continue
          end
          table.insert(qflist, {filename = item.path, lnum = item.row, text = item.value})
          ::continue::
        end
        if #qflist == 0 then
          return
        end
        vim.cmd("tabnew")
        vim.fn.setqflist(qflist)
        vim.cmd("Qfreplace")
        vim.cmd("only")
      end,
    },

    ["vim/variable"] = {
      action_edit = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        require("cmdbuf").split_open(vim.o.cmdwinheight, {line = "let " .. item.value})
        vim.cmd("normal! $")
      end,
    },

  },

  source = {

    line = {
      filters = {"regex", "-regex", "substring", "-substring"},
      global_opts = {auto = "preview"},
    },

    ["vim/jump"] = {global_opts = {auto = "preview"}},
    ["vim/substitute"] = {global_opts = {auto = "preview"}},
    ["vim/filetype"] = {sorters = {"length"}},

    ["plugin"] = {sorters = {"alphabet"}},
    ["thetto/source"] = {sorters = {"length"}},

    ["git/branch"] = {sorters = {"length"}},

    ["file/in_dir"] = {colors = colors},
    ["file/mru"] = {colors = colors, global_opts = {auto = "preview"}},
    ["file/recursive"] = {
      colors = colors,
      opts = {get_command = file_recursive},
      sorters = {"length"},
      global_opts = {auto = "preview"},
    },
    ["file/directory/recursive"] = {
      opts = {get_command = directory_recursive},
      sorters = {"length"},
    },

    ["vim/help"] = {sorters = {"length"}},
    ["vim/buffer"] = {global_opts = {auto = "preview"}},

    ["cmdhndlr/executed"] = {global_opts = {auto = "preview"}},

    ["file/grep"] = {
      opts = {
        command = "pt",
        command_opts = {
          "--nogroup",
          "--nocolor",
          "--smart-case",
          "--ignore=.git",
          "--ignore=.mypy_cache",
          "--ignore=tags",
          "--hidden",
        },
        pattern_opt = "",
        recursive_opt = "",
        separator = "--",
      },
      filters = {"substring", "-substring", "substring:path:relative", "-substring:path:relative"},
      colors = colors,
      global_opts = {auto = "preview"},
    },

    ["file/bookmark"] = {
      opts = {
        default_paths = {
          "~/.local/share/nvim/rplugin.vim",
          "~/dotfiles/vim/rc/local/local.vim",
          "~/.local/.bashrc",
          "~/.bashrc",
          "~/.local/.bash_profile",
          "~/.bash_profile",
          "~/workspace/*",
        },
      },
    },

    ["cmd/ctags"] = {
      opts = {ignore = {"member", "package", "packageName", "anonMember", "constant"}},
      global_opts = {auto = "preview"},
      filters = {"regex", "-regex"},
    },

    ["cmd/make/target"] = {global_opts = {auto = "preview"}},

    ["git/diff"] = {global_opts = {auto = "preview"}},

    ["env/manual"] = {sorters = {"length"}},

    ["file/alter"] = {
      global_opts = {auto = "preview", immediately = true, insert = false},
      opts = {
        pattern_groups = {
          {"%_test.go", "%.go"},
          {"%/spec/lua/%_spec.lua", "%/lua/%.lua"},
          {"%/test/lua/%_spec.lua", "%/lua/%.lua"},
          {"%.c", "%.h"},
        },
      },
    },

    ["vim/variable"] = {global_opts = {action = "edit"}},

    ["github/pr"] = {global_opts = {action = "browser_open"}},
    ["github/issue"] = {global_opts = {action = "browser_open"}},
    ["github/milestone"] = {global_opts = {action = "browser_open"}},

    ["cmd/zsh/history"] = {
      sorters = {"length"},
      global_opts = {target = "upward", target_patterns = {"Makefile"}},
    },

  },

  source_actions = {

    ["vim/filetype"] = {
      action_open_proto = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        local filetype = item.value
        local name = require("filetypext").detect({filetype = filetype})[1]
        vim.fn["notomo#vimrc#open_sandbox"](name, filetype)
      end,
    },

    ["url/bookmark"] = {action_browser_open = brwoser_open, opts = {yank = {key = "url"}}},
    ["github/pr"] = {action_browser_open = brwoser_open},
    ["github/issue"] = {action_browser_open = brwoser_open},
    ["github/milestone"] = {action_browser_open = brwoser_open},

  },

  global_opts = {display_limit = 500},

  filters = {"substring", "-substring"},
})

