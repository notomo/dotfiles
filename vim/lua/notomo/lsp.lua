
local nvimlsp = require'nvim_lsp'

nvimlsp.tsserver.setup{}
nvimlsp.rls.setup{}
nvimlsp.gopls.setup{}
nvimlsp.pyls.setup{}
nvimlsp.clangd.setup{}
nvimlsp.tsserver.setup{}

-- local util = require 'nvim_lsp/util'
-- nvimlsp.efm.setup{
--   filetypes = {"vim"};
--   -- filetypes = {"vim", "go", "python"};
--   root_dir = function(fname)
--     local dir = util.root_pattern(".git")(fname) or vim.loop.cwd()
--     return dir
--   end;
-- }

vim.lsp.set_log_level('error')

vim.lsp.callbacks['textDocument/formatting'] = function(err, method, result, client_id)
end
vim.lsp.callbacks['window/showMessage'] = function(err, method, result, client_id)
end
vim.lsp.callbacks['window/logMessage'] = function(err, method, result, client_id)
end
vim.lsp.callbacks['textDocument/publishDiagnostics'] = function(err, method, result, client_id)
end

-- local method = 'textDocument/publishDiagnostics'
-- local default = vim.lsp.callbacks[method]
-- vim.lsp.callbacks[method] = function(err, method, result, client_id)
--   -- TODO: fix for multiple client on the same filetype
--   default(err, method, result, client_id)
--   if result and result.diagnostics then
--     for _, v in ipairs(result.diagnostics) do
--       v.uri = v.uri or result.uri
--     end
--     vim.lsp.util.set_qflist(result.diagnostics)
--   end
-- end
