local dap = require("dap")
dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input("Port: "))
      assert(val, "Please provide a port number")
      return val
    end,
  },
}
dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host, port = config.port })
end

vim.keymap.set("n", "[term]s", [[<Cmd>lua require("dap").step_into()<CR>]])
vim.keymap.set("n", "[term]b", [[<Cmd>lua require("dap").toggle_breakpoint()<CR>]])
vim.keymap.set("n", "[term]B", [[<Cmd>lua require("dap").clear_breakpoints()<CR>]])
vim.keymap.set("n", "[term]n", [[<Cmd>lua require("dap").step_over()<CR>]])
vim.keymap.set("n", "[term]c", [[<Cmd>lua require("dap").continue()<CR>]])
vim.keymap.set("n", "[term]f", [[<Cmd>lua require("dap").terminate()<CR>]])
vim.keymap.set("n", "[keyword]e", [[<Cmd>lua require('dap.ui.widgets').hover()<CR>]])
