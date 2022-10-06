local M = {}

local enable = function(client, bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)

  local root_dir = client.config.root_dir
  if not vim.endswith(root_dir, "/") then
    root_dir = root_dir .. "/"
  end

  if vim.startswith(path, root_dir) then
    return false
  end

  vim.lsp.stop_client(client.id)
  require("null-ls").enable({ method = require("null-ls").methods.FORMATTING })
  return true
end

local _format = function(client, bufnr)
  local params = vim.lsp.util.make_formatting_params()
  local method = "textDocument/formatting"
  client.request(method, params, function(...)
    local handler = client.handlers[method] or vim.lsp.handlers[method]
    handler(...)
    vim.api.nvim_buf_call(bufnr, function()
      return vim.cmd.update({ mods = { silent = true, noautocmd = true } })
    end)
  end, bufnr)
end

local format = function(bufnr)
  -- don't specify buffer to reuse client
  local null_ls_client = vim.lsp.get_active_clients({ name = "null-ls" })[1]
  if not null_ls_client then
    return require("misclib.message").warn("no null-ls client")
  end

  local reloading = enable(null_ls_client, bufnr)
  if not reloading then
    return _format(null_ls_client, bufnr)
  end

  local group = vim.api.nvim_create_augroup("notomo_lsp_format_async", { clear = false })
  vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
  vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = group,
    buffer = bufnr,
    callback = function()
      local client = vim.lsp.get_active_clients({ name = "null-ls" })[1]
      if not client then
        return require("misclib.message").warn("no null-ls client")
      end
      _format(client, bufnr)
      return true
    end,
  })
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
