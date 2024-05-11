local M = {}

vim.g._debug_args = {}
vim.g._debug_watched = {}
function M.start()
  vim.g.termdebug_map_K = 0
  vim.cmd.packadd([[termdebug]])

  local path = vim.fn.expand("~/workspace/neovim/")
  local nvim = path .. "build/bin/nvim"
  local rc = vim.fn.expand("$DOTFILES/tool/nvim_development/debugrc.vim")

  local current = vim.fn.expand("%:p")
  local in_repo = vim.startswith(current, path)
  if not in_repo then
    vim.cmd.tabedit()
    vim.cmd.tcd(path)
  end

  local args = { nvim }
  vim.list_extend(args, vim.g._debug_args)
  vim.list_extend(args, { "-u", rc })
  vim.cmd.TermdebugCommand({ args = args })
  vim.cmd.Source()
  if in_repo then
    vim.cmd.Break()
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
  vim.keymap.set("n", "[keyword]E", [[:Evaluate<CR>]])
end

function M.quit()
  if vim.fn.exists("*TermDebugSendCommand") ~= 1 then
    return
  end
  local ok, result = pcall(function()
    vim.fn.TermDebugSendCommand("quit")
    vim.fn.TermDebugSendCommand("y")
  end)
  ---@diagnostic disable-next-line: need-check-nil
  if not ok and not result:find([[Can't send data to closed stream]]) then
    error(result)
  end
end

return M
