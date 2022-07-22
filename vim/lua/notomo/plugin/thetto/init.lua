require("thetto").setup_store("file/mru")

vim.api.nvim_set_hl(0, "ThettoColorLabelLua", { bg = "#7098e6" })
vim.api.nvim_set_hl(0, "ThettoColorLabelVim", { bg = "#33aa77" })
vim.api.nvim_set_hl(0, "ThettoColorLabelGo", { bg = "#70ffe6" })
vim.api.nvim_set_hl(0, "ThettoColorLabelPythonBlue", { bg = "#3333dd" })
vim.api.nvim_set_hl(0, "ThettoColorLabelPythonYellow", { bg = "#fedf81" })
vim.api.nvim_set_hl(0, "ThettoColorLabelDir", { bg = "#a9dd9d" })

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
    return { "fd", "--hidden", "--color=never", "--exclude", ".git", "-L", "--max-depth", max_depth, "-t", "d", ".", path }
  end
  modify_path = function(path)
    return path
  end
end

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

local cmdhndlr_driver = function(cmd, opts)
  require("cmdhndlr").run({
    name = "cmdhndlr/raw",
    working_dir = function()
      return opts.cwd
    end,
    layout = { type = "no" },
    runner_opts = { cmd = cmd },
  })
end

local run_without_focus = function(...)
  local keys = { ... }
  return function(_, items)
    local targets = vim.tbl_map(function(item)
      for _, key in ipairs(keys) do
        local v = item[key]
        if v then
          return v
        end
      end
    end, items)
    require("notomo.autohotkey").run_without_focus(targets)
  end
end

require("thetto").setup({

  kind_actions = {

    ["git/branch"] = {
      action_tab_open = function(_, items)
        local cursor = vim.api.nvim_win_get_cursor(0)
        for _, item in ipairs(items) do
          vim.cmd.Gina({ args = { "show", item.value .. ":%:p", "--opener=tabedit" } })
          require("misclib.cursor").set(cursor)
        end
      end,
      action_compare = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        vim.cmd.Gina({ args = { "compare", item.value .. ":" } })
      end,
      action_diff = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        vim.cmd.Gina({ args = { "diff", item.value } })
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
        vim.cmd.tabnew()
        vim.fn.setqflist(qflist)
        vim.cmd.Qfreplace()
        vim.cmd.only()
      end,
      action_system = run_without_focus("url", "path"),
    },

    ["vim/variable"] = {
      action_edit = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        require("cmdbuf").split_open(vim.o.cmdwinheight, { line = "let " .. item.value })
        vim.cmd.normal({ args = { "$" }, bang = true })
      end,
    },

    ["vim/option"] = {
      action_edit = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        require("cmdbuf").split_open(vim.o.cmdwinheight, { line = "setlocal " .. item.value })
        vim.cmd.normal({ args = { "$" }, bang = true })
      end,
    },

    ["vim/command"] = {
      action_open = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        require("cmdbuf").split_open(vim.o.cmdwinheight, { line = item.value })
        vim.cmd.normal({ args = { "$" }, bang = true })
      end,
    },

    ["url"] = {
      action_open_browser = function(_, items)
        for _, item in ipairs(items) do
          vim.cmd.OpenBrowser(item.url)
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

    ["keymap"] = { global_opts = { auto = "preview" } },

    ["vim/jump"] = { global_opts = { auto = "preview" } },
    ["vim/substitute"] = { global_opts = { auto = "preview" } },
    ["vim/filetype"] = { sorters = { "length" } },

    ["plugin"] = { sorters = { "alphabet" }, global_opts = { auto = "preview" } },
    ["thetto/source"] = { sorters = { "length" } },

    ["git/branch"] = { sorters = { "length" } },

    ["file/in_dir"] = { colors = colors, global_opts = { auto = "preview" } },
    ["file/mru"] = { colors = colors, global_opts = { auto = "preview" } },
    ["file/recursive"] = {
      colors = colors,
      opts = { get_command = file_recursive },
      sorters = { "length" },
      global_opts = { auto = "preview" },
    },
    ["file/directory/recursive"] = {
      opts = { get_command = directory_recursive, modify_path = modify_path },
      sorters = { "length" },
      global_opts = { auto = "preview" },
    },

    ["vim/help"] = { sorters = { "length" }, global_opts = { auto = "preview" } },
    ["vim/buffer"] = { global_opts = { auto = "preview" } },

    ["cmdhndlr/executed"] = { global_opts = { auto = "preview" } },
    ["cmdhndlr/runner"] = { global_opts = { action = "execute" } },

    ["vendor_target"] = { global_opts = { action = "add" } },
    ["vim/diagnostic"] = {
      global_opts = { auto = "preview" },
      filters = {
        "substring",
        "-substring",
        "substring:path:relative",
        "-substring:path:relative",
      },
    },

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

    ["vim/lsp/references"] = {
      global_opts = { cwd = require("thetto.util").cwd.project(), auto = "preview" },
      filters = {
        "substring:path",
        "-substring:path",
      },
    },
    ["vim/lsp/workspace_symbol"] = {
      filters = {
        "interactive",
        "substring",
        "-substring",
        "substring:kind",
        "substring:path:relative",
        "-substring:path:relative",
      },
      global_opts = { cwd = require("thetto.util").cwd.project(), auto = "preview" },
    },
    ["vim/lsp/document_symbol"] = {
      global_opts = { cwd = require("thetto.util").cwd.project(), auto = "preview" },
    },
    ["vim/lsp/implementation"] = {
      global_opts = { cwd = require("thetto.util").cwd.project(), auto = "preview" },
    },
    ["vim/lsp/incoming_calls"] = {
      filters = { "substring", "-substring", "substring:path:relative", "-substring:path:relative" },
      global_opts = { cwd = require("thetto.util").cwd.project(), auto = "preview" },
    },
    ["vim/lsp/outgoing_calls"] = {
      filters = { "substring", "-substring", "substring:path:relative", "-substring:path:relative" },
      global_opts = { cwd = require("thetto.util").cwd.project(), auto = "preview" },
    },

    ["file/bookmark"] = {
      opts = {
        default_paths = {
          "~/dotfiles/vim/rc/local/local.vim",
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
      global_opts = { auto = "preview" },
    },

    ["cmd/ctags"] = {
      opts = { ignore = { "member", "package", "packageName", "anonMember", "constant" } },
      global_opts = { auto = "preview" },
      filters = { "regex", "-regex" },
    },

    ["cmd/make/target"] = { global_opts = { auto = "preview" } },

    ["git/diff"] = { global_opts = { auto = "preview" } },
    ["git/log"] = { global_opts = { auto = "preview" } },

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

    ["go/package"] = { global_opts = { auto = "preview" } },
    ["go/document"] = { global_opts = { auto = "preview" } },
    ["python/attribute"] = { global_opts = { auto = "preview" } },
    ["lua/luarocks"] = { global_opts = { auto = "preview" } },

    ["github/user"] = {
      filters = { "interactive", "regex", "-regex" },
    },
    ["github/search_repository"] = {
      filters = { "interactive", "regex", "-regex" },
    },
    ["github/issue"] = {
      filters = { "interactive", "regex", "-regex" },
    },
    ["cmd/zsh/completion"] = {
      filters = { "interactive", "substring", "-substring" },
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
          vim.cmd.OpenBrowser(item.url)
        end
      end,
      action_docfilter = function(_, items)
        for _, item in ipairs(items) do
          require("docfilter").open(item.url)
        end
      end,
      opts = { yank = { key = "url" } },
    },

    ["cmd/make/target"] = {
      opts = {
        execute = { driver = cmdhndlr_driver },
      },
    },
    ["cmd/npm/script"] = {
      opts = {
        execute = { driver = cmdhndlr_driver },
      },
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

    ["cmdhndlr/runner"] = {
      action_execute = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        require("cmdhndlr").execute(item.value)
      end,
    },

    ["vendor_target"] = {
      action_add = function(_, items)
        require("vendorlib").add(
          vim.tbl_map(function(item)
            return item.value
          end, items),
          { path = "spec/lua/%s/vendorlib.lua" }
        )
      end,
    },

    ["plugin"] = {
      action_search = function(_, items)
        local item = items[1]
        if item == nil then
          return
        end
        local bufnr = vim.fn.bufadd(vim.fn.expand("~/dotfiles/vim/lua/notomo/plugin/_list.lua"))
        vim.fn.bufload(bufnr)
        require("thetto").start("line", {
          opts = {
            input_lines = { [[add("]] .. item.value },
            immediately = true,
            insert = false,
            can_resume = false,
          },
          source_opts = { bufnr = bufnr },
        })
      end,
      action_enable_hot_reloading = function(_, items)
        for _, item in ipairs(items) do
          local name = vim.split(item.value, "/", true)[2]:gsub("%.nvim$", "")
          require("lreload").enable(name)
        end
      end,
      action_disable_hot_reloading = function(_, items)
        for _, item in ipairs(items) do
          local name = vim.split(item.value, "/", true)[2]:gsub("%.nvim$", "")
          require("lreload").disable(name)
        end
      end,
    },
  },

  global_opts = { display_limit = 500 },

  filters = { "substring", "-substring" },
})
