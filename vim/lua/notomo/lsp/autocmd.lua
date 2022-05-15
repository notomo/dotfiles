local M = {}

function M.setup()
  require("null-ls") -- to lazy load
  local group = vim.api.nvim_create_augroup("notomo_lsp_format", { clear = false })
  local events = { "BufWritePre" }
  vim.api.nvim_clear_autocmds({ event = events, buffer = 0, group = group })
  vim.api.nvim_create_autocmd(events, {
    buffer = 0,
    group = group,
    callback = function()
      vim.lsp.buf.format({
        filter = function(clients)
          return vim.tbl_filter(function(client)
            return client.name == "null-ls"
          end, clients)
        end,
      })
    end,
  })
end

return M
