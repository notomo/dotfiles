local M = {}

local TAB_MODE = "tab"
local TAB_KEY = ("[%s]"):format(TAB_MODE)

function M.setup(enter_key, mappings)
  for _, m in ipairs(mappings) do
    vim.fn["submode#enter_with"](TAB_MODE, "nx", "", TAB_KEY .. m.lhs, m.rhs)
    vim.fn["submode#map"](TAB_MODE, "n", "", m.lhs, m.rhs)
  end
  vim.fn["submode#leave_with"](TAB_MODE, "n", "", "j")
  vim.fn.feedkeys(TAB_KEY .. enter_key)
end

return M
