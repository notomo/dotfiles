local M = {}

--- @param scope "g"|"b"
local function to_let_lines(scope)
  assert(scope == "g" or scope == "b", "invalid scope: " .. tostring(scope))
  -- stringify on vimscript side: funcref/float/blob are lost in lua conversion
  local vars = vim.fn.eval(("map(copy(%s:), {_, v -> string(v)})"):format(scope))
  local lines = {}
  for name, str in vim.spairs(vars) do
    if not (scope == "b" and name == "changedtick") then
      -- string() emits raw newlines only inside single-quoted literals
      str = str:gsub("\n", [[' .. "\n" .. ']])
      table.insert(lines, ("let %s:%s = %s"):format(scope, name, str))
    end
  end
  return lines
end

local sources = {
  history = function(lines)
    return vim
      .iter(lines)
      :filter(function(line)
        return not line:match("^Git push")
      end)
      :totable()
  end,
  lua = function(lines)
    return vim
      .iter(lines)
      :filter(function(line)
        return line:match("^%s*lua[%s=]") ~= nil or line:match("^%s*=") ~= nil
      end)
      :totable()
  end,
  global = function()
    return to_let_lines("g")
  end,
  buffer = function(_, ctx)
    return vim.api.nvim_buf_call(ctx.bufnr, function()
      return to_let_lines("b")
    end)
  end,
}

local pending = nil

--- @param opts {type:"history"|"lua"|"global"|"buffer"?, line:string?}?
function M.open(opts)
  opts = opts or {}
  pending = {
    type = opts.type or "history",
    line = opts.line,
    bufnr = vim.api.nvim_get_current_buf(),
  }
  vim.api.nvim_feedkeys("q:", "n", false)
end

function M.on_enter(bufnr)
  vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buf = bufnr, nowait = true })
  vim.keymap.set({ "n", "i" }, "<C-q>", "<C-c>", { buf = bufnr })
  vim.keymap.set("n", "<CR>", "<CR>", { buf = bufnr })

  local ctx = pending or { type = "history" }
  pending = nil
  if vim.fn.getcmdwintype() ~= ":" then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local last = table.remove(lines) or ""
  local new_lines = sources[ctx.type](lines, ctx)
  local line = ctx.line or last
  table.insert(new_lines, line)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
  vim.api.nvim_win_set_cursor(0, { #new_lines, math.max(#line - 1, 0) })
end

return M
