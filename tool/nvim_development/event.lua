local Session = require("nvim.session")
local ChildProcessStream = require("nvim.child_process_stream")

local M = {}

function M.spawn()
  local args = {"nvim", "--embed", "-u", "NONE", "-i", "NONE"}
  local child_stream = ChildProcessStream.spawn(args)
  return Session.new(child_stream)
end

local session = M.spawn()

function M.request(method, ...)
  local ok, result = session:request(method, ...)
  if not ok then
    error(result)
  end
  print(vim.inspect(result))
  return result
end

M.request("nvim_ui_attach", 30, 30, {ext_multigrid = true, ext_linegrid = true})
M.request("nvim_list_uis")

session:run(function(...)
  print(vim.inspect({...}))
end, function(...)
  print(vim.inspect({...}))
end, 1000)

session:close()
