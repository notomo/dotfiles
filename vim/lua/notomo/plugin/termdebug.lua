local M = {}

vim.g._debug_args = {}
vim.g._debug_watched = {}
function M.start()
  vim.cmd([[packadd termdebug]])

  local path = vim.fn.expand("~/workspace/neovim/")
  local nvim = path .. "build/bin/nvim"
  local rc = vim.fn.expand("~/dotfiles/tool/nvim_development/debugrc.vim")

  local current = vim.fn.expand("%:p")
  local in_repo = vim.startswith(current, path)
  if not in_repo then
    vim.cmd([[tabedit | tcd ]] .. path)
  end

  local args = table.concat(vim.g._debug_args, " ")
  vim.cmd(("TermdebugCommand %s %s -u %s"):format(nvim, args, rc))
  vim.cmd([[Source]])
  if in_repo then
    vim.cmd([[Break]])
  end
  for _, v in ipairs(vim.g._debug_watched) do
    vim.fn.TermDebugSendCommand("watch " .. v)
  end
  vim.fn.TermDebugSendCommand("run")

  vim.keymap.set("n", "[term]s", [[<Cmd>Step<CR>]])
  vim.keymap.set("n", "[term]b", [[<Cmd>Break<CR>]])
  vim.keymap.set("n", "[term]B", [[<Cmd>Clear<CR>]])
  vim.keymap.set("n", "[term]n", [[<Cmd>Over<CR>]])
  vim.keymap.set("n", "[term]c", [[<Cmd>Continue<CR>]])
  vim.keymap.set("n", "[term]f", [[<Cmd>Finish<CR>]])
  vim.keymap.set("n", "[keyword]e", [[:Evaluate<CR>]])
end

function M.quit()
  if vim.fn.exists("*TermDebugSendCommand") ~= 1 then
    return
  end
  local ok, result = pcall(function()
    vim.fn.TermDebugSendCommand("quit")
    vim.fn.TermDebugSendCommand("y")
  end)
  if not ok and not result:find([[Can't send data to closed stream]]) then
    error(result)
  end
end

return M
