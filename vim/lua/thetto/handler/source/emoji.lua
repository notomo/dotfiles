local M = {}

function M.collect()
  return vim
    .iter(vim.fn["emoji#data#dict"]())
    :map(function(name, codes)
      if type(codes) ~= "table" then
        codes = { codes }
      end
      local emoji = vim
        .iter(codes)
        :map(function(code)
          return vim.fn.nr2char(code)
        end)
        :join("")
      return {
        value = ("%s %s"):format(emoji, name),
        emoji = emoji,
      }
    end)
    :totable()
end

M.kind_name = "word"

M.actions = {
  opts = {
    append = { key = "emoji" },
  },
  default_action = "append",
}

M.modify_pipeline = require("thetto.util.pipeline").append({
  require("thetto.util.sorter").field_length_by_name("value"),
})

return M
