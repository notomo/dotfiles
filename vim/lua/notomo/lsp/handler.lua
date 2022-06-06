local M = {}

function M.publish_diagnostics(err, result, ctx, config)
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
  vim.diagnostic.setloclist({
    open = false,
    namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id),
  })
end

function M.dart_publish_outline(_, result, ctx)
  vim.api.nvim_buf_set_var(ctx.bufnr or 0, "_thetto_dart_outline", result)
end

function M.dart_publish_flutter_outline(_, result, ctx)
  vim.api.nvim_buf_set_var(ctx.bufnr or 0, "_thetto_flutter_outline", result)
end

M.ignore_progress = { "null-ls" }
function M.progress()
  local messages = vim.tbl_filter(function(msg)
    return not vim.tbl_contains(M.ignore_progress, msg.name)
  end, vim.lsp.util.get_progress_messages())
  for _, msg in ipairs(messages) do
    if msg.done and not msg.message then
      msg.message = "done"
    end
    print(("[%s] %s: %s"):format(msg.name, msg.title, msg.message))
  end
end

vim.lsp.set_log_level("error")

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
  require("notomo.lsp.handler").publish_diagnostics(...)
end
vim.lsp.handlers["dart/textDocument/publishOutline"] = function(...)
  require("notomo.lsp.handler").dart_publish_outline(...)
end
vim.lsp.handlers["dart/textDocument/publishFlutterOutline"] = function(...)
  require("notomo.lsp.handler").dart_publish_flutter_outline(...)
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
vim.keymap.set("n", "[lc]k", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], { silent = true })
vim.keymap.set("n", "[lc]D", [[<Cmd>lua vim.lsp.buf.type_definition()<CR>]], { silent = true })
vim.keymap.set("n", "[lc]K", [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]], { silent = true })
vim.keymap.set("n", "[lc]s", [[<Cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>]], { silent = true })
vim.keymap.set("n", "[exec]gn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { silent = true })
vim.keymap.set("n", "[exec]gf", [[<Cmd>lua vim.lsp.buf.format({async = true})<CR>]])
vim.keymap.set("n", "[keyword]c", [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], { silent = true })
vim.keymap.set("x", "[keyword]c", [[:lua vim.lsp.buf.range_code_action()<CR>]], { silent = true })

local original_select = vim.ui.select
vim.ui.select = function(items, opts, on_choice)
  if opts.kind == "codeaction" and #items == 1 and items[1][2].kind == "refactor.extract" then
    require("misclib.message").info("Executed: " .. items[1][2].title, "Title")
    return on_choice(items[1])
  end
  original_select(items, opts, on_choice)
end

return M
