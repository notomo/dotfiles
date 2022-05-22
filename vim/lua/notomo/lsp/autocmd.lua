local M = {}

local format = function(bufnr)
  local client = vim.lsp.get_active_clients({ name = "null-ls" })[1]
  if not client then
    return require("misclib.message").warn("no null-ls client")
  end

  local params = vim.lsp.util.make_formatting_params()
  local method = "textDocument/formatting"
  client.request(method, params, function(...)
    local handler = client.handlers[method] or vim.lsp.handlers[method]
    handler(...)
    vim.api.nvim_buf_call(bufnr, function()
      return vim.cmd([[silent noautocmd update]])
    end)
  end, bufnr)
end

function M.setup()
  require("null-ls") -- to lazy load
  local group = vim.api.nvim_create_augroup("notomo_lsp_format", { clear = false })
  local events = { "BufWritePost" }
  vim.api.nvim_clear_autocmds({ buffer = 0, group = group })
  vim.api.nvim_create_autocmd(events, {
    buffer = 0,
    group = group,
    callback = function(args)
      local bufnr = args.buf
      if vim.b[bufnr].notomo_lsp_format_disabled then
        return
      end
      format(bufnr)
    end,
  })
end

return M
