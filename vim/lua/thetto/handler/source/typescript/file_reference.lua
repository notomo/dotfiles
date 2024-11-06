local M = {}

function M.collect(source_ctx)
  return function(observer)
    local method = "workspace/executeCommand"
    local client = vim.lsp.get_clients({
      bufnr = source_ctx.bufnr,
      method = method,
      name = "vtsls",
    })[1]
    if not client then
      observer:error("not found client")
      return
    end

    local params = {
      command = "typescript.findAllFileReferences",
      arguments = { vim.lsp.util.make_text_document_params(source_ctx.bufnr).uri },
    }
    local ok, request_id = client.request(method, params, function(err, result)
      if err then
        observer:error(err)
        return
      end

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
      observer:complete()
    end)
    if not ok or not request_id then
      return
    end

    return function()
      client.cancel_request(request_id)
    end
  end
end

M.kind_name = "file"

M.cwd = require("thetto.util.cwd").project()

return M
