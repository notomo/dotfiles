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

local source_actions = require("thetto/kind").source_user_actions
source_actions["vim/filetype"] = {
  open_proto = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    vim.fn["notomo#vimrc#open_proto"](item.value)
  end,
}
