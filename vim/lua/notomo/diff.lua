local M = {}

function M.diff(...)
  local args = { ... }

  local tab_target = ""
  local paths = {}
  if #args == 1 then
    tab_target = "%:p"
    paths = args
  elseif #args >= 2 then
    tab_target = args[1]
    paths = vim.list_slice(args, 2)
  end

  vim.cmd.tabedit(tab_target)
  for _, path in ipairs(paths) do
    vim.cmd.diffsplit({ mods = { split = "belowright", vertical = true }, args = { path } })
  end
end

return M
