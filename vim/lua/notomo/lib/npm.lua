local M = {}

function M.update(path)
  path = vim.fn.fnamemodify(path, ":p")
  local dir = vim.fn.fnamemodify(path, ":p:h")
  vim.cmd.lcd(dir)

  local lines = vim.fn.systemlist({ "npm", "outdated" })
  lines = vim.list_slice(lines, 2)

  local latests = {}
  for _, line in ipairs(lines) do
    local splitted = vim.split(line, "%s+")
    if #splitted ~= 0 then
      table.insert(latests, {
        name = splitted[1],
        version = splitted[4],
      })
    end
  end
  print(vim.inspect(latests))

  vim.cmd.tabedit(path)
  for _, latest in ipairs(latests) do
    local target_pattern = ([[\v\s+"%s": "]]):format(vim.fn.escape(latest.name, "@"))
    local found_lnum = vim.fn.search(target_pattern)
    if found_lnum then
      local new_line = ([["%s": "^%s"]]):format(latest.name, latest.version)
      vim.fn.setline(found_lnum, new_line)
    end
  end
end

return M
