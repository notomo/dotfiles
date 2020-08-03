local M = {}

local char_to_hex = function(c)
  return ("%%%02X"):format(c:byte())
end

local encode = function(url)
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w _%%%-%.~/:%?@=])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

M.collect = function(self)
  local file_path = self.pathlib.user_data_path("url_bookmark.txt")
  if self.filelib.create_if_need(file_path) then
    local f = io.open(file_path, "w")
    f:write("sample\thttps://github.com/notomo/dotfiles")
    f:close()
  end

  local items = {}
  local f = io.open(file_path, "r")
  local i = 1
  for line in f:lines() do
    local url = encode(vim.fn.reverse(vim.split(line, "\t", true))[1])
    table.insert(items, {value = line, path = file_path, row = i, url = url})
    i = i + 1
  end
  f:close()

  return items
end

M.kind_name = "file"

return M
