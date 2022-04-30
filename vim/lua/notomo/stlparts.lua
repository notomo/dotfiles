local surround = function(s)
  return ("[%s]"):format(s)
end

local path = function()
  return vim.fn.expand("%:p:~")
end

local filetype = function()
  return surround(vim.bo.filetype)
end

local branch = function()
  if vim.fn.exists("*gina#component#repo#branch") == 0 then
    return ""
  end
  local ok, name = pcall(vim.fn["gina#component#repo#branch"])
  if not ok then
    return ""
  end
  if #name == 0 then
    return ""
  end
  return surround(name)
end

local column = function()
  return surround(vim.fn.col("."))
end

local modes = {
  n = "N",
  i = "I",
  R = "R",
  v = "V",
  V = "V",
  [vim.api.nvim_eval('"\\<C-v>"')] = "V",
  c = "C",
  s = "S",
  [vim.api.nvim_eval('"\\<C-s>"')] = "S",
  t = "T",
}
local mode = function()
  local mode = vim.fn.mode()
  return modes[mode] or ""
end

local cwd = function()
  return vim.fn.getcwd()
end

local stlparts = require("stlparts")

local IfNormalWindow = stlparts.component("if_normal_window")
local TrancateLeft = stlparts.component("trancate_left")
local Padding = stlparts.component("padding")
local IfActiveWindow = stlparts.component("if_active_window")
local Separate = stlparts.component("separate")
local FileType = stlparts.component("file_type")
local List = stlparts.component("list")

local active = Separate(List({ path, branch }), List({ column, filetype, mode }))
local inactive = path
stlparts.set_root(
  IfNormalWindow(
    TrancateLeft(Padding(FileType({ ["kivi-file"] = List({ cwd, branch }) }, IfActiveWindow(active, inactive))))
  )
)

vim.opt.statusline = [[%!v:lua.require("stlparts").build()]]
