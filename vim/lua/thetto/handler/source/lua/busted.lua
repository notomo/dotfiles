local M = {}

function M.collect()
  local items = {}

  local query = vim.treesitter.parse_query(
    "lua",
    [[
(function_call (identifier) @var (match? @var "describe"))
(function_call (identifier) @var (match? @var "it"))
]]
  )

  local bufnr = vim.api.nvim_get_current_buf()
  local path = vim.fn.expand("%:p")
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local parser = vim.treesitter.get_parser(bufnr, "lua")
  local trees, _ = parser:parse()
  local it = query:iter_captures(trees[1]:root(), bufnr, 0, -1)
  for _, node in it do
    local row = unpack({ node:range() })
    local line = lines[row + 1]
    table.insert(items, { value = line, row = row + 1, path = path })
  end

  return items
end

M.kind_name = "file"

return M
