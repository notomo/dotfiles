local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local actionlint = {
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  filetypes = {"yaml"},
  generator = null_ls.generator({
    command = "actionlint",
    args = {"-oneline"},
    to_stdin = false,
    format = "line",
    check_exit_code = function(code)
      return code == 0 or code == 1
    end,
    on_output = helpers.diagnostics.from_pattern([=[^[^:]+:(%d+):(%d+): (.*)]=], {
      "row",
      "col",
      "message",
    }),
  }),
}
null_ls.register(actionlint)
null_ls.setup({})
