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

vim.lsp.set_log_level("error")

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
  require("notomo.lsp.handler").publish_diagnostics(...)
end

vim.api.nvim_create_augroup("notomo_lsp_progress", {})
vim.api.nvim_create_autocmd({ "User" }, {
  group = "notomo_lsp_progress",
  pattern = { "LspProgressUpdate" },
  callback = function()
    require("notomo.lsp.handler").progress()
  end,
})

require("notomo.mapping.util").set_prefix({ "n" }, "lc", "<Leader>f")
vim.keymap.set("n", "[lc]D", [[<Cmd>lua vim.lsp.buf.type_definition()<CR>]], { silent = true })
vim.keymap.set("n", "[lc]K", [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]], { silent = true })
vim.keymap.set("n", "[lc]s", function()
  vim.diagnostic.hide()
  vim.lsp.stop_client(vim.lsp.get_active_clients(), false)
end, { silent = true })
vim.keymap.set("n", "[exec]gn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { silent = true })
vim.keymap.set("n", "[exec]gf", [[<Cmd>lua vim.lsp.buf.format({async = true})<CR>]])
vim.keymap.set({ "n", "x" }, "[keyword]c", [[:lua vim.lsp.buf.code_action()<CR>]], { silent = true })
vim.keymap.set("n", "[keyword]e", [[<Cmd>lua vim.lsp.buf.hover()<CR>]])

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

vim.ui.input = require("notomo.input").open

return M
