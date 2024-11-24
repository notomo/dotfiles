local M = {}

function M.collect(source_ctx)
  return function(observer)
    local bufnr = source_ctx.bufnr
    local method = vim.lsp.protocol.Methods.workspace_executeCommand
    local cancel = require("thetto.util.lsp").request({
      bufnr = bufnr,
      method = method,
      clients = vim.lsp.get_clients({
        bufnr = bufnr,
        method = method,
        name = "vtsls",
      }),
      params = function(client)
        local position_params = vim.lsp.util.make_position_params(source_ctx.window_id, client.offset_encoding)
        return {
          command = "typescript.goToSourceDefinition",
          arguments = { position_params.textDocument.uri, position_params.position },
        }
      end,
      observer = {
        next = function(result, ctx)
          local client = vim.lsp.get_clients({ id = ctx.client_id })[1]
          local location_items = vim.lsp.util.locations_to_items(result, client.offset_encoding)
          local items = vim
            .iter(location_items)
            :map(function(e)
              local relative_path = require("thetto.lib.path").to_relative(e.filename, source_ctx.cwd)
              local value = ("%s:%s:%d"):format(relative_path, e.lnum, e.col)
              return {
                value = value,
                path = e.filename,
                row = e.lnum,
              }
            end)
            :totable()

          observer:next(items)
        end,
        complete = function()
          observer:complete()
        end,
        error = function(err)
          observer:error(err)
        end,
      },
    })
    return cancel
  end
end

M.kind_name = "file"

M.cwd = require("thetto.util.cwd").project()

return M
