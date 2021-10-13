local M = {}

local TYPE_QUICKFIX = 1
local TYPE_LOCLIST = 2

function M.open()
  local typ = M._type()
  if not typ then
    return
  end
  if typ == TYPE_QUICKFIX then
    return vim.cmd("copen")
  end
  if typ == TYPE_LOCLIST then
    return vim.cmd("lopen")
  end
end

function M.next()
  local typ = M._type()
  if not typ then
    return
  end
  if typ == TYPE_QUICKFIX then
    return M._wrap_move("cnext", "cfirst")
  end
  if typ == TYPE_LOCLIST then
    return M._wrap_move("lnext", "lfirst")
  end
end

function M.prev()
  local typ = M._type()
  if not typ then
    return
  end
  if typ == TYPE_QUICKFIX then
    return M._wrap_move("cprevious", "clast")
  end
  if typ == TYPE_LOCLIST then
    return M._wrap_move("lprevious", "llast")
  end
end

function M._type()
  if vim.bo.filetype == "qf" then
    local info = vim.fn.getwininfo()[1]
    return info.quickfix ~= 0 and TYPE_QUICKFIX or TYPE_LOCLIST
  end
  if #vim.fn.getloclist(0) > 0 then
    return TYPE_LOCLIST
  end
  if #vim.fn.getqflist() > 0 then
    return TYPE_QUICKFIX
  end
end

function M._wrap_move(try_cmd, catch_cmd)
  local ok, result = pcall(vim.cmd, try_cmd)
  if ok then
    return
  end
  if vim.endswith(result, "E553: No more items") then
    return vim.cmd(catch_cmd)
  end
  error(result)
end

return M
