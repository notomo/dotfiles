local M = {}

function M.open()
  local dir_path = vim.fn.expand("~/workspace/diary")

  local diary_path = vim.fs.joinpath(dir_path, vim.fn.strftime("%Y%m%d.txt"))
  vim.cmd.drop({ mods = { tab = 0 }, args = { diary_path } })
  vim.bo.filetype = "mydiary"

  local current_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "")
  if current_content ~= "" then
    return
  end

  vim.cmd([[write ++p]])
  vim.fn.chdir(dir_path, "tabpage")

  local dir = vim.fn.reverse(vim.fn.readdir("."))
  local others = vim.list_slice(dir, 2)
  if vim.tbl_isempty(others) then
    return
  end

  local before = others[1]
  local f = io.open(before, "r")
  if not f then
    return
  end
  local content = f:read("*a")
  f:close()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
  vim.cmd.write()
end

return M
