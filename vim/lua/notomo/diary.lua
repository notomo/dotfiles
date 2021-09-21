local M = {}

function M.open()
  local dir_path = vim.fn.expand("~/workspace/diary")
  if vim.fn.isdirectory(dir_path) ~= 1 then
    vim.fn.mkdir(dir_path, "p")
  end

  local diary_path = dir_path .. "/" .. vim.fn.strftime("%Y%m%d.txt")
  vim.cmd("tab drop " .. diary_path)
  vim.cmd("lcd " .. dir_path)
  vim.opt_local.filetype = "mydiary"

  local current_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "")
  if current_content ~= "" then
    return
  end

  vim.cmd("write")

  local dir = vim.fn.reverse(vim.fn.readdir("."))
  local others = vim.list_slice(dir, 2)
  if vim.tbl_isempty(others) then
    return
  end

  local before = others[1]
  local f = io.open(before, "r")
  local content = f:read("*a")
  f:close()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
  vim.cmd("write")
end

return M
