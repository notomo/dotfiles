local M = {}

local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

M.url_encode = function(url)
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w ])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

M.cursor_url_encode = function()
  local target = vim.api.nvim_call_function("expand", {"<cWORD>"})
  return M.url_encode(target)
end

local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

M.url_decode = function(url)
  url = url:gsub("+", " ")
  url = url:gsub("%%(%x%x)", hex_to_char)
  return url
end

M.cursor_url_decode = function()
  local target = vim.api.nvim_call_function("expand", {"<cWORD>"})
  return M.url_decode(target)
end

return M

