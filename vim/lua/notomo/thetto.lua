require("lreload").enable("thetto", {
  post_hook = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/thetto.lua"))
  end,
})

require("thetto").setup_store("file/mru")

vim.cmd([[
highlight! ThettoColorLabelLua guibg=#7098e6
highlight! ThettoColorLabelVim guibg=#33aa77
highlight! ThettoColorLabelGo guibg=#70ffe6
highlight! ThettoColorLabelPythonBlue guibg=#3333dd
highlight! ThettoColorLabelPythonYellow guibg=#fedf81
highlight! ThettoColorLabelDir guibg=#a9dd9d
]])

local colors = {
  { pattern = ".lua$", chunks = { { " ", "ThettoColorLabelLua" } } },
  { pattern = ".go$", chunks = { { " ", "ThettoColorLabelGo" } } },
  { pattern = ".vim$", chunks = { { " ", "ThettoColorLabelVim" } } },
  {
    pattern = ".py$",
    chunks = { { " ", "ThettoColorLabelPythonYellow" }, { " ", "ThettoColorLabelPythonBlue" } },
  },
  { pattern = "/$", chunks = { { " ", "ThettoColorLabelDir" } } },
  { always = true, pattern = "", chunks = { { " ", "ThettoColorLabelOthers" } } },
}

local file_recursive, directory_recursive
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

  local ignore_dirs = { ".git", "node_modules", ".mypy_cache" }
  local cmds = {}
  for _, name in ipairs(ignore_dirs) do
    vim.list_extend(cmds, { "-type", "d", "-name", name, "-prune", "-o" })
  end
  vim.list_extend(cmds, { "-type", "d", "-print" })
  directory_recursive = function(path, max_depth)
    local cmd = { "find", "-L", path, "-maxdepth", max_depth }
    vim.list_extend(cmd, cmds)
    return cmd
  end
end

-- TODO move to setup
require("thetto.handler.kind.file.directory").after = function(path)
  require("kivi").open({ path = path })
end

require("thetto").setup({

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
          table.insert(qflist, { filename = item.path, lnum = item.row, text = item.value })
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
        require("cmdbuf").split_open(vim.o.cmdwinheight, { line = "let " .. item.value })
        vim.cmd("normal! $")
      end,
    },

    ["vim/option"] = {
      action_edit = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        require("cmdbuf").split_open(vim.o.cmdwinheight, { line = "setlocal " .. item.value })
        vim.cmd("normal! $")
      end,
    },

    ["vim/command"] = {
      action_open = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        require("cmdbuf").split_open(vim.o.cmdwinheight, { line = item.value })
        vim.cmd("normal! $")
      end,
    },

    ["url"] = {
      action_open_browser = function(_, items)
        for _, item in ipairs(items) do
          vim.cmd("OpenBrowser " .. item.url)
        end
      end,
      action_docfilter = function(_, items)
        for _, item in ipairs(items) do
          require("docfilter").open(item.url)
        end
      end,
    },
  },

  source = {

    line = {
      filters = { "regex", "-regex", "substring", "-substring" },
      global_opts = { auto = "preview" },
    },

    ["vim/jump"] = { global_opts = { auto = "preview" } },
    ["vim/substitute"] = { global_opts = { auto = "preview" } },
    ["vim/filetype"] = { sorters = { "length" } },

    ["plugin"] = { sorters = { "alphabet" } },
    ["thetto/source"] = { sorters = { "length" } },

    ["git/branch"] = { sorters = { "length" } },

    ["file/in_dir"] = { colors = colors },
    ["file/mru"] = { colors = colors, global_opts = { auto = "preview" } },
    ["file/recursive"] = {
      colors = colors,
      opts = { get_command = file_recursive },
      sorters = { "length" },
      global_opts = { auto = "preview" },
    },
    ["file/directory/recursive"] = {
      opts = { get_command = directory_recursive },
      sorters = { "length" },
    },

    ["vim/help"] = { sorters = { "length" } },
    ["vim/buffer"] = { global_opts = { auto = "preview" } },

    ["cmdhndlr/executed"] = { global_opts = { auto = "preview" } },

    ["file/grep"] = {
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
      colors = colors,
      global_opts = { auto = "preview" },
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
      opts = { ignore = { "member", "package", "packageName", "anonMember", "constant" } },
      global_opts = { auto = "preview" },
      filters = { "regex", "-regex" },
    },

    ["cmd/make/target"] = { global_opts = { auto = "preview" } },

    ["git/diff"] = { global_opts = { auto = "preview" } },

    ["env/manual"] = { sorters = { "length" } },

    ["file/alter"] = {
      global_opts = { auto = "preview", immediately = true, insert = false },
      opts = {
        pattern_groups = {
          { "%_test.go", "%.go" },
          { "%/spec/lua/%_spec.lua", "%/lua/%.lua" },
          { "%/test/lua/%_spec.lua", "%/lua/%.lua" },
          { "%.c", "%.h" },
        },
      },
    },

    ["vim/variable"] = { global_opts = { action = "edit" } },

    ["cmd/zsh/history"] = {
      sorters = { "length" },
      global_opts = { cwd = require("thetto.util").cwd.upward({ "Makefile" }) },
    },
  },

  source_actions = {

    ["vim/filetype"] = {
      action_open_scratch = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        local filetype = item.value
        local name = require("filetypext").detect({ filetype = filetype })[1]
        require("notomo.edit").scratch(name, filetype)
      end,
    },

    ["url/bookmark"] = {
      action_browser_open = function(_, items)
        for _, item in ipairs(items) do
          vim.cmd("OpenBrowser " .. item.url)
        end
      end,
      action_docfilter = function(_, items)
        for _, item in ipairs(items) do
          require("docfilter").open(item.url)
        end
      end,
      opts = { yank = { key = "url" } },
    },

    ["test"] = {
      action_execute = function(_, items)
        local window_id = vim.api.nvim_get_current_win()
        for _, item in ipairs(items) do
          vim.api.nvim_set_current_win(window_id)
          require("cmdhndlr").test({ filter = item.value, is_leaf = item.is_leaf, layout = { type = "tab" } })
        end
      end,
    },
  },

  global_opts = { display_limit = 500 },

  filters = { "substring", "-substring" },
})
