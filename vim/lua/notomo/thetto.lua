require("thetto/kind/directory").after = function(_)
  vim.api.nvim_command("Kiview -create -split=no")
end

require("thetto/source/file/mru").ignore_pattern = "\\v(^(gina|thetto|term|kiview)://|denite-filter$|\\[denite\\]-default$)"

local grep = require("thetto/source/grep")
grep.command = "pt"
grep.opts = {"--nogroup", "--nocolor", "--smart-case", "--ignore=.git", "--ignore=tags", "--hidden"}
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
