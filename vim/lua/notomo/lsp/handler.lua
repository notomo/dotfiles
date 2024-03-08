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

function M.references(err, result)
  if err then
    require("misclib.message").warn(err)
    return
  end
  if not result then
    require("misclib.message").warn("no references")
    return
  end

  require("thetto").start({
    collect = function()
      return vim
        .iter(result)
        :map(function(e)
          local path = vim.uri_to_fname(e.uri)
          local row = e.range.start.line + 1
          return {
            value = ("%s:%d"):format(path, row),
            path = path,
            row = row,
            end_row = e.range["end"].line,
            column = e.range.start.character,
            end_column = e.range["end"].character,
          }
        end)
        :totable()
    end,
    consumer_opts = { ui = { insert = false } },
    name = "notomo/lsp/references",
    kind_name = "file",
  })
end

vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_publishDiagnostics] = function(...)
  require("notomo.lsp.handler").publish_diagnostics(...)
end

vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_references] = function(...)
  require("notomo.lsp.handler").references(...)
end

vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_hover] = function(...)
  require("lsp-handler-intercept").wrap(vim.lsp.handlers.hover)(...)
end

vim.api.nvim_create_autocmd({ "LspProgress" }, {
  group = vim.api.nvim_create_augroup("notomo_lsp_progress", {}),
  pattern = { "end" },
  callback = function(args)
    local done_clients = vim.g.notomo_done_clients or {}
    done_clients[tostring(args.data.client_id)] = true
    vim.g.notomo_done_clients = done_clients
    vim.cmd.redrawstatus()
  end,
})

vim.ui.select = function(items, opts, on_choice)
  if opts.kind == "codeaction" and vim.tbl_get(items, 1, 2, "kind") == "refactor.extract" then
    require("misclib.message").info("Executed: " .. items[1][2].title, "Title")
    return on_choice(items[1])
  end

  local item_cursor_factory, get_range
  if opts.kind == "codeaction" then
    local current_row = vim.fn.line(".")
    item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
      if not (item.row and item.end_row) then
        return false
      end
      return item.row == current_row or item.end_row == current_row
    end)
    get_range = function(item)
      local range = vim.tbl_get(item, 2, "command", "arguments", 1, "Range") -- gopls
      if not range then
        return nil
      end
      return require("thetto.util.lsp").range(range)
    end
  end

  require("thetto.util.source").start_by_name("vim/select", {
    opts = {
      items = items,
      prompt = opts.prompt,
      format_item = opts.format_item,
      on_choice = on_choice,
      get_range = get_range,
    },
  }, {
    item_cursor_factory = item_cursor_factory,
  })
end

vim.ui.input = require("notomo.lib.input").open

vim.lsp.set_log_level("error")

return M
