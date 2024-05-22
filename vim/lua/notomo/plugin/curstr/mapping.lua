vim.keymap.set(
  "n",
  "[keyword]fo",
  [[<Cmd>lua require("curstr").execute("openable", {action = "open"})<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[keyword]ft",
  [[<Cmd>lua require("curstr").execute("openable", {action = "tab_open"})<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[keyword]fv",
  [[<Cmd>lua require("curstr").execute("openable", {action = "vertical_open"})<CR>]],
  { silent = true }
)
vim.keymap.set(
  "n",
  "[keyword]fh",
  [[<Cmd>lua require("curstr").execute("openable", {action = "horizontal_open"})<CR>]],
  { silent = true }
)
vim.keymap.set("n", "[edit]s", function()
  local cmd = require("curstr").operator("togglable") .. "$"
  vim.cmd.normal({ args = { cmd }, bang = true })
end)
vim.keymap.set("n", "[edit]k", function()
  local cmd = require("curstr").operator("snake_kebab") .. "$"
  vim.cmd.normal({ args = { cmd }, bang = true })
end)
vim.keymap.set("n", "<Space>rj", function()
  local cmd = require("curstr").operator("print", { action = "append" }) .. "$"
  vim.cmd.normal({ args = { cmd }, bang = true })
end)
vim.keymap.set("n", "[edit]J", function()
  vim.ui.input({
    prompt = "Separator: ",
  }, function(separator)
    local cmd = require("curstr").operator("range", { action = "join", action_opts = { separator = separator } }) .. "G"
    vim.cmd.normal({ args = { cmd }, bang = true })
  end)
end)
vim.keymap.set("x", "[edit]J", function()
  vim.ui.input({
    prompt = "Separator: ",
  }, function(separator)
    vim.cmd.normal({ args = { "gv" }, bang = true })

    local cmd = require("curstr").operator("range", {
      action = "join",
      action_opts = {
        separator = separator,
        offset = math.abs(vim.fn.line("v") - vim.fn.line(".")),
      },
    })
    vim.cmd.normal({ args = { cmd }, bang = true })
  end)
end)

vim.keymap.set({ "x", "o" }, "ig", function()
  require("curstr").execute("vim/line/inner")
end)
vim.keymap.set({ "x", "o" }, "ag", function()
  require("curstr").execute("vim/line/around")
end)
vim.keymap.set({ "x", "o" }, "ae", function()
  require("curstr").execute("vim/entire/around")
end)
