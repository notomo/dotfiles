require("thetto/kind/directory").after = function(path)
  vim.api.nvim_command("Kiview -create -split=no -path=" .. path)
end

require("thetto/setup/file/mru").ignore_pattern = "\\v(^(gina|thetto|term|kiview)://)"
require("thetto/source/file/recursive").get_command = function(path, max_depth)
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
local extended_cmd = {}
for _, name in ipairs(ignore_dirs) do
  vim.list_extend(extended_cmd, {"-type", "d", "-name", name, "-prune", "-o"})
end
vim.list_extend(extended_cmd, {"-type", "d", "-print"})
require("thetto/source/directory/recursive").get_command = function(path, max_depth)
  local cmd = {"find", "-L", path, "-maxdepth", max_depth}
  vim.list_extend(cmd, extended_cmd)
  return cmd
end

local grep = require("thetto/source/file/grep")
grep.command = "pt"
grep.command_opts = {
  "--nogroup",
  "--nocolor",
  "--smart-case",
  "--ignore=.git",
  "--ignore=.mypy_cache",
  "--ignore=tags",
  "--hidden",
}
grep.pattern_opt = ""
grep.recursive_opt = ""
grep.separator = "--"

local file_bookmark = require("thetto/source/file/bookmark")
file_bookmark.default_paths = {
  "~/.local/share/nvim/rplugin.vim",
  "~/dotfiles/vim/rc/local/local.vim",
  "~/.local/.bashrc",
  "~/.bashrc",
  "~/.local/.bash_profile",
  "~/.bash_profile",
}

local source_actions = require("thetto/custom").source_actions
source_actions["vim/filetype"] = {
  action_open_proto = function(_, items)
    local item = items[1]
    if item == nil then
      return
    end
    vim.fn["notomo#vimrc#open_proto"](item.value)
  end,
}
source_actions["url/bookmark"] = {
  action_browser_open = function(_, items)
    for _, item in ipairs(items) do
      if item.url ~= nil then
        vim.api.nvim_command("OpenBrowser " .. item.url)
      end
    end
  end,
  opts = {yank = {key = "url"}},
}

local kind_actions = require("thetto/custom").kind_actions
kind_actions["git/branch"] = {
  action_tab_open = function(_, items)
    for _, item in ipairs(items) do
      local cmd = ("Gina show %s:%%:p --opener=tabedit"):format(item.value)
      vim.api.nvim_command(cmd)
    end
  end,
  action_compare = function(_, items)
    local item = items[1]
    if item == nil then
      return
    end
    local cmd = ("Gina compare %s:"):format(item.value)
    vim.api.nvim_command(cmd)
  end,
  action_diff = function(_, items)
    local item = items[1]
    if item == nil then
      return
    end
    local cmd = ("Gina diff %s:"):format(item.value)
    vim.api.nvim_command(cmd)
  end,
}

kind_actions["file"] = {
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
    vim.api.nvim_command("tabnew")
    vim.fn.setqflist(qflist)
    vim.api.nvim_command("Qfreplace")
    vim.api.nvim_command("only")
  end,
}

vim.api.nvim_command("highlight! ThettoColorLabelLua guibg=#7098e6")
vim.api.nvim_command("highlight! ThettoColorLabelVim guibg=#33aa77")
vim.api.nvim_command("highlight! ThettoColorLabelGo guibg=#70ffe6")
vim.api.nvim_command("highlight! ThettoColorLabelPythonBlue guibg=#3333dd")
vim.api.nvim_command("highlight! ThettoColorLabelPythonYellow guibg=#fedf81")
vim.api.nvim_command("highlight! ThettoColorLabelDir guibg=#a9dd9d")
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
require("thetto/source/file/in_dir").colors = colors
require("thetto/source/file/mru").colors = colors
require("thetto/source/file/recursive").colors = colors
require("thetto/source/file/grep").colors = colors
require("thetto/source/file/grep").filters = {"substring", "substring:path:relative"}
require("thetto/source/line").filters = {"regex", "-regex"}

require("thetto/source/outline").opts = {
  ignore = {"member", "package", "packageName", "anonMember"},
}

require("thetto/source/git/branch").sorters = {"length"}
require("thetto/custom").default_filters = {"substring", "-substring"}

require("thetto/source/file/alter").opts.pattern_groups = {
  {"%_test.go", "%.go"},
  {"%/test/lua/%_spec.lua", "%/lua/%.lua"},
}
