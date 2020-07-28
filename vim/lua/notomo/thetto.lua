require("thetto/kind/directory").after = function(path)
  vim.api.nvim_command("Kiview -create -split=no -path=" .. path)
end

require("thetto/source/file/mru").ignore_pattern = "\\v(^(gina|thetto|term|kiview)://|denite-filter$|\\[denite\\]-default$)"
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

local grep = require("thetto/source/grep")
grep.command = "pt"
grep.opts = {
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
file_bookmark.paths = {
  "~/.local/share/nvim/rplugin.vim",
  "~/dotfiles/vim/rc/local/local.vim",
  "~/.local/.bashrc",
  "~/.bashrc",
  "~/.local/.bash_profile",
  "~/.bash_profile",
  file_bookmark.file_path,
}

local source_actions = require("thetto/kind").source_user_actions
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
}
source_actions["emoji"] = {
  action_append = function(_, items)
    for _, item in ipairs(items) do
      vim.api.nvim_put({item.emoji}, "c", true, true)
    end
  end,
}

local kind_actions = require("thetto/kind").user_actions
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
