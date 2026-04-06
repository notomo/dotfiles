local M = {}

function M.operator(operator_type)
  if operator_type == nil then
    M._operator = function(...)
      require("notomo.lib.todo").operator(...)
    end
    vim.o.operatorfunc = "v:lua.require'notomo.lib.todo'._operator"
    return "g@"
  end

  local start_line = vim.fn.line("'[")
  local end_line = vim.fn.line("']")

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local new_lines = {}
  for _, line in ipairs(lines) do
    if line:match("^%s*%- %[.%]") then
      table.insert(new_lines, line)
    elseif line:match("^%s*%- ") then
      table.insert(new_lines, (line:gsub("^(%s*%- )", "%1[ ] ")))
    else
      table.insert(new_lines, "- [ ] " .. line)
    end
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
end

return M
