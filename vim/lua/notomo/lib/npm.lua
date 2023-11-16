local M = {}

function M.mapping()
  vim.keymap.set(
    "n",
    "[exec]bl",
    [[<Cmd>lua require("cmdhndlr").build({name = 'javascript/npm'})<CR>]],
    { buffer = true }
  )
  vim.keymap.set(
    "n",
    "[test]t",
    [[<Cmd>lua require("cmdhndlr").test({name = 'javascript/npm', layout = {type = "tab"}})<CR>]],
    { buffer = true }
  )
  vim.keymap.set(
    "n",
    "[exec],",
    [[<Cmd>lua require("thetto").start("cmd/npm/script", {opts = {sorters = {"alphabet"},  cwd = require("thetto.util.cwd").project() , insert = false}})<CR>]],
    { buffer = true }
  )
end

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
