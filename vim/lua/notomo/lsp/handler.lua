local M = {}

local ignored_diagnostic = {
  -- diagnostic.source = {diagnostic.code = true}
  deno = { ["import-map-remap"] = true },
}
function M.publish_diagnostics(err, result, ctx, config)
  result.diagnostics = vim.tbl_filter(function(e)
    return not vim.tbl_get(ignored_diagnostic, e.source, e.code)
  end, result.diagnostics)

  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
  vim.diagnostic.setloclist({
    open = false,
    namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id),
  })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
  require("notomo.lsp.handler").publish_diagnostics(...)
end

M.ignored_progress = { "null-ls" }
function M.progress()
  local messages = vim.tbl_filter(function(msg)
    if vim.tbl_contains(M.ignored_progress, msg.name) then
      return false
    end
    return msg.done or not msg.percentage
  end, vim.lsp.util.get_progress_messages())
  for _, msg in ipairs(messages) do
    if msg.done and not msg.message then
      msg.message = "done"
    end
    local text = ("[%s] %s: %s"):format(msg.name, msg.title, msg.message)
    vim.api.nvim_echo({ { text } }, msg.done, {})
  end
end

vim.api.nvim_create_autocmd({ "User" }, {
  group = vim.api.nvim_create_augroup("notomo_lsp_progress", {}),
  pattern = { "LspProgressUpdate" },
  callback = function()
    require("notomo.lsp.handler").progress()
  end,
})

vim.ui.select = function(items, opts, on_choice)
  if opts.kind == "codeaction" and #items == 1 and items[1][2].kind == "refactor.extract" then
    require("misclib.message").info("Executed: " .. items[1][2].title, "Title")
    return on_choice(items[1])
  end

  require("thetto").start("vim/select", {
    source_opts = {
      items = items,
      prompt = opts.prompt,
      format_item = opts.format_item,
      on_choice = on_choice,
    },
  })
end

vim.ui.input = require("notomo.lib.input").open

vim.lsp.set_log_level("error")

return M
