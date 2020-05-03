
local nvimlsp = require'nvim_lsp'

nvimlsp.tsserver.setup{}
nvimlsp.rls.setup{}
nvimlsp.gopls.setup{}
nvimlsp.pyls.setup{}
nvimlsp.clangd.setup{}
nvimlsp.tsserver.setup{}

-- local util = require 'nvim_lsp/util'
-- nvimlsp.efm.setup{
--   cmd = {"efm-langserver", "-logfile=/tmp/efm.log"};
--   filetypes = {"vim", "go", "python"};
--   root_dir = function(fname)
--     local dir = util.root_pattern(".git")(fname) or vim.loop.cwd()
--     return dir
--   end;
-- }

vim.lsp.set_log_level('error')

vim.lsp.callbacks['textDocument/formatting'] = function(_, _, _, _)
end
vim.lsp.callbacks['window/showMessage'] = function(_, _, _, _)
end
vim.lsp.callbacks['window/logMessage'] = function(_, _, _, _)
end

-- local nss = {}
-- 
-- local get_or_create_ns = function(client_id)
--   local client = vim.lsp.get_client_by_id(client_id)
--   if not client then
--     return
--   end
-- 
--   local ns = nss[client.name]
--   if ns then
--     return ns
--   end
-- 
--   ns = vim.api.nvim_create_namespace("lsp_diagnostics_" .. client.name)
--   nss[client.name] = ns
--   return ns
-- end
-- 
-- local clear_diagnostics = function(bufnr, client_id)
--   vim.validate { bufnr = {bufnr, 'n', true} }
--   local buf = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
--   local ns = get_or_create_ns(client_id)
--   vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
-- end
-- 
-- local set_vritualtext = function(bufnr, result, client_id)
--   if not result.diagnostics then
--     return
--   end
-- 
--   local ns = get_or_create_ns(client_id)
--   for _, v in ipairs(result.diagnostics) do
--     local severity_name = vim.lsp.protocol.DiagnosticSeverity[v.severity]
--     local highlight = "LspDiagnostics"..severity_name
-- 
--     local pos = v.range.start
--     local chunks = {{" "..v.message:gsub("\r", ""):gsub("\n", "  "), highlight}}
--     vim.api.nvim_buf_set_virtual_text(bufnr, ns, pos.line, chunks, {})
--   end
-- end
-- 
-- local set_qflist = function(bufnr, result, client_id)
--   if not result.diagnostics then
--     return
--   end
-- 
--   local items = {}
--   for _, v in ipairs(result.diagnostics) do
--     local pos = v.range.start
-- 
--     local severity = ''
--     if v.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
--       severity = 'E'
--     elseif v.severity == vim.lsp.protocol.DiagnosticSeverity.Warning then
--       severity = 'W'
--     else
--       severity = 'I'
--     end
-- 
--     local item = {
--       bufnr = bufnr,
--       filename = vim.uri_to_fname(v.uri or result.uri),
--       lnum = pos.line + 1,
--       col = pos.character + 1,
--       text = v.message,
--       type = severity,
--     }
--     table.insert(items, item)
--   end
--   vim.fn.setqflist({}, 'r', {
--     title = 'lsp';
--     items = items;
--   })
-- end
-- 
-- vim.lsp.callbacks['textDocument/publishDiagnostics'] = function(_, _, result, client_id)
--   clear_diagnostics(bufnr, client_id)
--   if not result then
--     return
--   end
-- 
--   local uri = result.uri
--   local bufnr = vim.uri_to_bufnr(uri)
--   if not bufnr then
--     return
--   end
-- 
--   set_vritualtext(bufnr, result, client_id)
--   set_qflist(bufnr, result, client_id)
-- end

vim.lsp.callbacks['textDocument/publishDiagnostics'] = function(_, _, _, _)
end
