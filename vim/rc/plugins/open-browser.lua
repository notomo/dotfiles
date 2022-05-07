require("notomo.mapping.util").set_prefix({ "n", "x" }, "browser", "[exec]b")

vim.keymap.set("n", "[browser]s", [[<Cmd>execute 'OpenBrowserSearch' expand('<cword>')<CR>]])
vim.keymap.set("n", "[browser]o", [[<Cmd>execute 'OpenBrowser' expand('<cWORD>')<CR>]])
vim.keymap.set("n", "[browser]i", [[:<C-u>OpenBrowserSearch<Space>]])
vim.keymap.set("n", "[browser]y", [[<Cmd>execute 'OpenBrowser' getreg('+')<CR>]])

if not vim.fn.empty(vim.env.SSH_CLIENT) and vim.fn.has("mac") == 1 and vim.fn.executable("lemonade") then
  vim.g.openbrowser_browser_commands = { { name = "lemonade", args = "lemonade open {uri}" } }
elseif vim.fn.has("wsl") == 1 then
  vim.g.openbrowser_browser_commands = { { name = "wslview", args = "wslview {uri}" } }
end
