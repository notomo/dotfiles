local M = {}

function M.collect(source_ctx)
  local bufnr = source_ctx.bufnr
  local path = vim.api.nvim_buf_get_name(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  return vim
    .iter(lines)
    :enumerate()
    :filter(function(_, line)
      return line:match("^#+ .+")
    end)
    :map(function(i, line)
      local hashes = line:match("^(#+)")
      local indent = (" "):rep((#hashes - 1) * 2)
      return {
        value = indent .. line,
        row = i,
        path = path,
      }
    end)
    :totable()
end

M.kind_name = "file"

return M
