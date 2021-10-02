local M = {}

local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

function M.url_encode(url)
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w %/:.])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

function M.cursor_url_encode()
  local target = vim.fn.expand("<cWORD>")
  return M.url_encode(target)
end

local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

function M.url_decode(url)
  url = url:gsub("+", " ")
  url = url:gsub("%%(%x%x)", hex_to_char)
  return url
end

function M.cursor_url_decode()
  local target = vim.fn.expand("<cWORD>")
  return M.url_decode(target)
end

return M
