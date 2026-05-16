local M = {}

local ns = vim.api.nvim_create_namespace("notomo.lib.replace")

local function set_highlight(bufnr, start_pos, end_pos)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  vim.api.nvim_buf_set_extmark(bufnr, ns, start_pos[2] - 1, start_pos[3] - 1, {
    end_row = end_pos[2] - 1,
    end_col = end_pos[3],
    hl_group = "ReplacedText",
    strict = false,
  })

  local group = vim.api.nvim_create_augroup("notomo.lib.replace", {})
  vim.schedule(function()
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = bufnr,
      once = true,
      callback = function()
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      end,
    })
  end)
end

function M.operator(operator_type)
  if operator_type == nil then
    M._operator = function(...)
      require("notomo.lib.replace").operator(...)
    end
    vim.o.operatorfunc = "v:lua.require'notomo.lib.replace'._operator"
    return "g@"
  end

  local reg = vim.fn.getreg("+")
  local start_pos = vim.fn.getpos("'[")
  local end_pos = vim.fn.getpos("']")

  if operator_type == "line" then
    local lines = vim.split(reg, "\n", { plain = true })
    if lines[#lines] == "" then
      table.remove(lines)
    end
    vim.api.nvim_buf_set_lines(0, start_pos[2] - 1, end_pos[2], false, lines)
    local hl_end_row = start_pos[2] + #lines - 1
    local last_line = vim.api.nvim_buf_get_lines(0, hl_end_row - 1, hl_end_row, false)[1] or ""
    set_highlight(0, { 0, start_pos[2], 1, 0 }, { 0, hl_end_row, #last_line, 0 })
  elseif operator_type == "char" then
    local lines = vim.split(reg, "\n", { plain = true })
    if lines[#lines] == "" then
      table.remove(lines)
    end
    local end_line = vim.api.nvim_buf_get_lines(0, end_pos[2] - 1, end_pos[2], false)[1] or ""
    local last_byte = math.min(end_pos[3], #end_line)
    -- getpos("']") points to the first byte of the last character, so extend
    -- end_col to cover its whole multibyte sequence (exclusive end).
    local end_col = last_byte > 0 and (last_byte + vim.str_utf_end(end_line, last_byte)) or 0
    vim.api.nvim_buf_set_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_col, lines)
    local hl_end_row = start_pos[2] + #lines - 1
    local hl_end_col = #lines == 1 and (start_pos[3] + #lines[1] - 1) or #lines[#lines]
    set_highlight(0, start_pos, { 0, hl_end_row, hl_end_col, 0 })
  end
end

function M.search_pattern()
  local tmp = vim.fn.getreg("+")
  vim.cmd.normal({ args = { [[""y]] }, bang = true })
  local text = vim.fn.escape(vim.fn.getreg('"'), [[\/]])
  vim.fn.setreg("+", tmp)
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
