local M = {}

function M.setup()
  vim.keymap.set("n", "[yank]U", [[<Cmd>Gina browse : --yank<CR>:echomsg 'yank ' . @+<CR>]])
  vim.keymap.set("x", "[yank]U", [[:Gina browse : --yank --exact<CR>:echomsg 'yank ' . @+<CR>]])

  local relpath = function()
    local git = vim.fn["gina#core#get_or_fail"]()
    local abspath = vim.fn["gina#core#repo#abspath"](git, "")
    local curpath = vim.fn.substitute(vim.fn.expand("%:p"), "\\", "/", "g")
    return vim.fn.substitute(curpath, abspath, "", "")
  end
  vim.keymap.set("n", "[git]B", function()
    return ":<C-u>Gina blame :" .. relpath() .. "<CR>"
  end, { expr = true })
end

return M
