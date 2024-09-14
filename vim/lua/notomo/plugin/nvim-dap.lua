local group = vim.api.nvim_create_augroup("dap_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "dap-float" },
  callback = function()
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
  end,
})

local dap = require("dap")

dap.defaults.fallback.switchbuf = "uselast"

local on_finished = function(session, _)
  print("Finished:", vim.inspect(session.config, { newline = " ", indent = " " }))
end
dap.listeners.before["event_exited"]["notomo"] = on_finished
dap.listeners.before["event_terminated"]["notomo"] = on_finished

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

dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    vim.fn.expand("~/app/local-lua-debugger-vscode/extension/debugAdapter.js"),
  },
  enrich_config = function(config, on_config)
    ---@diagnostic disable-next-line: undefined-field
    if not config.extensionPath then
      local c = vim.deepcopy(config)
      ---@diagnostic disable-next-line: inject-field
      c.extensionPath = vim.fn.expand("~/app/local-lua-debugger-vscode")
      on_config(c)
      return
    end
    on_config(config)
  end,
}

require("nvim-dap-virtual-text").setup({
  commented = true,
  virt_text_pos = "eol",
})

local highlightlib = require("misclib.highlight")
highlightlib.define("DapStopped", {
  bg = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false }).bg,
  fg = vim.api.nvim_get_hl(0, { name = "CursorLineNr", link = false }).fg,
  bold = true,
})
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
