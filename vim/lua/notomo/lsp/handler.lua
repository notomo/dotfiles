local M = {}

function M.publish_diagnostics(err, result, ctx, config)
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
  vim.diagnostic.setloclist({
    open = false,
    namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id),
  })
end

function M.references(_, result)
  if not result or result == {} then
    return
  end
  require("thetto").start("lsp_adapter/text_document_references", {
    opts = { target = "project", auto = "preview" },
    source_opts = { result = result },
  })
end

function M.symbol(_, result)
  if not result or result == {} then
    return
  end
  require("thetto").start("lsp_adapter/workspace_symbol", {
    opts = { target = "project", auto = "preview" },
    source_opts = { result = result },
  })
end

function M.document_symbol(_, result)
  if not result or result == {} then
    return
  end
  require("thetto").start("lsp_adapter/text_document_document_symbol", {
    opts = { auto = "preview" },
    source_opts = { result = result },
  })
end

function M.implementation(_, result)
  if not result or result == {} then
    return
  end
  require("thetto").start("lsp_adapter/text_document_implementation", {
    opts = { target = "project", auto = "preview" },
    source_opts = { result = result },
  })
end

function M.definition(_, result, ctx)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end

  local util = vim.lsp.util
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if vim.tbl_islist(result) then
    util.jump_to_location(result[1], client.offset_encoding)
    if #result > 1 then
      vim.fn.setloclist(0, util.locations_to_items(result))
    end
  else
    util.jump_to_location(result, client.offset_encoding)
  end
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

function M.setting()
  vim.lsp.set_log_level("error")

  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
    require("notomo.lsp.handler").publish_diagnostics(...)
  end
  vim.lsp.handlers["textDocument/references"] = function(...)
    require("notomo.lsp.handler").references(...)
  end
  vim.lsp.handlers["workspace/symbol"] = function(...)
    require("notomo.lsp.handler").symbol(...)
  end
  vim.lsp.handlers["textDocument/documentSymbol"] = function(...)
    require("notomo.lsp.handler").document_symbol(...)
  end
  vim.lsp.handlers["textDocument/implementation"] = function(...)
    require("notomo.lsp.handler").implementation(...)
  end
  vim.lsp.handlers["textDocument/definition"] = function(...)
    require("notomo.lsp.handler").definition(...)
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

  require("notomo.mapping").set_prefix({ "n" }, "lc", "<Leader>f")
  vim.keymap.set("n", "[lc]d", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], { silent = true })
  vim.keymap.set("n", "[lc]k", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], { silent = true })
  vim.keymap.set("n", "[lc]D", [[<Cmd>lua vim.lsp.buf.type_definition()<CR>]], { silent = true })
  vim.keymap.set("n", "[lc]K", [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]], { silent = true })
  vim.keymap.set("n", "[lc]s", [[<Cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>]], { silent = true })
  vim.keymap.set("n", "[exec]gr", [[<Cmd>lua vim.lsp.buf.references()<CR>]], { silent = true })
  vim.keymap.set("n", "[exec]gn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { silent = true })
  vim.keymap.set("n", "[exec]gd", [[<Cmd>lua vim.lsp.buf.document_symbol()<CR>]], { silent = true })
  vim.keymap.set("n", "[exec]gw", [[<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>]], { silent = true })
  vim.keymap.set("n", "[keyword]c", [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], { silent = true })
  vim.keymap.set("n", "[exec]gi", [[<Cmd>lua vim.lsp.buf.implementation()<CR>]], { silent = true })
end

return M
