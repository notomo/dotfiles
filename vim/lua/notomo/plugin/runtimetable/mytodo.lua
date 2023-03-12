local runtime = require("runtimetable").new(require("notomo.plugin.runtimetable").path)

runtime.syntax["mytodo.lua"] = function()
  if vim.b.current_syntax then
    return
  end

  vim.cmd.syntax({ args = { "match", "mytodoDone", [["^\s*#.*"]] } })
  vim.api.nvim_set_hl(0, "mytodoDone", { default = true, link = "Comment" })

  vim.b.current_syntax = "mytodo"
end

runtime.after.ftplugin["mytodo.lua"] = function()
  vim.bo.commentstring = "#%s"
  vim.keymap.set("n", "[file]f", [[<Cmd>tab drop ~/workspace/todo/todo.tsv<CR>]], { buffer = true })
end

require("runtimetable").save(runtime)
