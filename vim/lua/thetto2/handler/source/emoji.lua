local M = {}

function M.collect()
  local items = {}
  for name, codes in pairs(vim.fn["emoji#data#dict"]()) do
    local char = ""
    if type(codes) == "table" then
      for _, code in ipairs(codes) do
        char = char .. vim.fn.nr2char(code)
      end
    else
      char = vim.fn.nr2char(codes)
    end
    local value = ("%s %s"):format(char, name)
    table.insert(items, { value = value, emoji = char })
  end
  return items
end

M.kind_name = "word"

M.default_action = "append"

M.actions = {
  opts = {
    append = { key = "emoji" },
  },
}

return M
