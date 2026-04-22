local M = {}

function M.operator(operator_type)
  if operator_type == nil then
    M._operator = function(...)
      require("notomo.lib.replace").operator(...)
    end
    vim.o.operatorfunc = "v:lua.require'notomo.lib.replace'._operator"
    return "g@"
  end

  local reg = vim.fn.getreg('"')
  local start_pos = vim.fn.getpos("'[")
  local end_pos = vim.fn.getpos("']")

  if operator_type == "line" then
    local lines = vim.split(reg, "\n", { plain = true })
    if lines[#lines] == "" then
      table.remove(lines)
    end
    vim.api.nvim_buf_set_lines(0, start_pos[2] - 1, end_pos[2], false, lines)
  elseif operator_type == "char" then
    local lines = vim.split(reg, "\n", { plain = true })
    if lines[#lines] == "" then
      table.remove(lines)
    end
    vim.api.nvim_buf_set_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], lines)
  end
end

function M.search_pattern()
  local tmp = vim.fn.getreg('"')
  vim.cmd.normal({ args = { [[""y]] }, bang = true })
  local text = vim.fn.escape(vim.fn.getreg('"'), [[\/]])
  vim.fn.setreg('"', tmp)
  return [[\V]] .. vim.fn.substitute(text, "\n", [[\\n]], "g")
end

function M.replace_next()
  M._operator = function(...)
    require("notomo.lib.replace").operator(...)
  end
  vim.o.operatorfunc = "v:lua.require'notomo.lib.replace'._operator"
  vim.cmd.normal({ args = { "g@gn" }, bang = true })
end

return M
