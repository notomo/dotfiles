require("notomo.mapping.util").set_prefix({ "n", "x" }, "browser", "[exec]b")

vim.keymap.set("n", "[browser]s", [[<Cmd>execute 'OpenBrowserSearch' expand('<cword>')<CR>]])
vim.keymap.set("n", "[browser]o", [[<Cmd>execute 'OpenBrowser' expand('<cWORD>')<CR>]])
vim.keymap.set("n", "[browser]i", [[:<C-u>OpenBrowserSearch ]])
vim.keymap.set("n", "[browser]I", [[:<C-u>OpenBrowserSearch -github ]])
vim.keymap.set("n", "[browser]m", [[:<C-u>OpenBrowserSearch -mdn ]])
vim.keymap.set("n", "[browser]y", [[<Cmd>execute 'OpenBrowser' getreg('+')<CR>]])

if not vim.fn.empty(vim.env.SSH_CLIENT) and vim.fn.has("mac") == 1 and vim.fn.executable("lemonade") then
  vim.g.openbrowser_browser_commands = { { name = "lemonade", args = "lemonade open {uri}" } }
elseif vim.fn.has("wsl") == 1 then
  vim.g.openbrowser_browser_commands = { { name = "wslview", args = "wslview {uri}" } }
end
vim.g.openbrowser_search_engines = {
  mdn = [[https://developer.mozilla.org/ja/search?q={query}]],
  docker = [[https://docs.docker.com/search/?q={query}]],
  mongo = [[https://www.mongodb.com/docs/search/?q={query}]],
  github_api = [[https://docs.github.com/en?query={query}]],
  ansible = [[https://docs.ansible.com/ansible/latest/index.html#stq={query}]],
  git = [[http://git-scm.com/search/results?search={query}]],
  deno = [[https://deno.land/x?query={query}]],
}
