local M = {}

--- @param f async fun()
--- @return vim.async.Task
function M.run(f)
  --- @async
  --- @return nil
  local run = function()
    local ok, err = pcall(f)
    if not ok and not vim.async.is_closing() then
      require("notomo.lib.message").warn(err)
    end
  end
  return vim.async.run(run)
end

return M
