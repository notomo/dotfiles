vim.api.nvim_create_augroup("dap_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "dap_setting",
  pattern = { "dap-float" },
  callback = function()
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
  end,
})

local dap = require("dap")

dap.defaults.fallback.switchbuf = "uselast"

dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
  options = {
    initialize_timeout_sec = 30,
  },
}

require("nvim-dap-virtual-text").setup({
  commented = true,
})

local highlightlib = require("misclib.highlight")
highlightlib.define("DapStopped", {
  bg = vim.api.nvim_get_hl_by_name("CursorLine", true).background,
  fg = vim.api.nvim_get_hl_by_name("CursorLineNr", true).foreground,
  bold = true,
})
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
