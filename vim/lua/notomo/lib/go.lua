local M = {}

function M.to_package(bin_path)
  local lines = vim.fn.systemlist({ "go", "version", "-m", "-v", bin_path })
  for _, line in ipairs(lines) do
    if vim.startswith(line, "\tpath\t") then
      local splitted = vim.split(line, "\t")
      return splitted[#splitted]
    end
  end
end

return M
