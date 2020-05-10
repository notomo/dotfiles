
local nvimlsp = require'nvim_lsp'

nvimlsp.rls.setup{}
nvimlsp.gopls.setup{
    init_options = {
      staticcheck=true,
      -- https://staticcheck.io/docs/checks
      analyses={ST1000=false},
    };
}
nvimlsp.pyls.setup{}
nvimlsp.clangd.setup{}
nvimlsp.tsserver.setup{}

local util = require 'nvim_lsp/util'
nvimlsp.efm.setup{
  cmd = {"efm-langserver", "-logfile=/tmp/efm.log"};
  filetypes = {"vim", "go", "python", "lua", "sh", "typescript.tsx", "typescript"};
  root_dir = function(fname)
    return util.root_pattern(".git")(fname) or vim.loop.cwd()
  end;
  on_attach = function(client)
    client.resolved_capabilities.text_document_save = true
    client.resolved_capabilities.text_document_save_include_text = true
  end;
}

vim.lsp.set_log_level('error')

vim.lsp.callbacks['textDocument/formatting'] = function(_, _, _, _)
end
vim.lsp.callbacks['window/showMessage'] = function(_, _, _, _)
end
vim.lsp.callbacks['window/logMessage'] = function(_, _, _, _)
end

local clear_diagnostics = function(bufnr, ns)
  vim.validate { bufnr = {bufnr, 'n', true} }
  local buf = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  vim.fn.setqflist({}, 'f')
  vim.fn.sign_unplace('vim_lsp_signs', {buffer=bufnr})
end

local set_vritualtext = function(bufnr, diagnostics, ns)
  for _, v in ipairs(diagnostics) do
    local severity_name = vim.lsp.protocol.DiagnosticSeverity[v.severity]
    local highlight = "LspDiagnostics"..severity_name

    local pos = v.range.start
    local chunks = {{" "..v.message:gsub("\r", ""):gsub("\n", "  "), highlight}}
    vim.api.nvim_buf_set_virtual_text(bufnr, ns, pos.line, chunks, {})
  end
end

local set_qflist = function(bufnr, uri, diagnostics)
  local items = {}
  for _, v in ipairs(diagnostics) do
    local pos = v.range.start

    local severity
    if v.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
      severity = 'E'
    elseif v.severity == vim.lsp.protocol.DiagnosticSeverity.Warning then
      severity = 'W'
    else
      severity = 'I'
    end

    local item = {
      bufnr = bufnr,
      filename = vim.uri_to_fname(v.uri or uri),
      lnum = pos.line + 1,
      col = pos.character + 1,
      text = v.message,
      type = severity,
    }
    table.insert(items, item)
  end
  vim.fn.setqflist({}, 'r', {
    title = 'lsp';
    items = items;
  })
end

local states = {}
local ns = vim.api.nvim_create_namespace("notomo_lsp_diagnostics")

vim.lsp.callbacks['textDocument/publishDiagnostics'] = function(_, _, result, client_id)
  if not result then
    return
  end

  local uri = result.uri
  local bufnr = vim.uri_to_bufnr(uri)
  if not bufnr then
    return
  end

  clear_diagnostics(bufnr, ns)
  local diagnostics = result.diagnostics
  if not diagnostics then
    return
  end

  local state = states[bufnr]
  if not state then
    state = {
      diagnostics = {},
      version = 0,
    }
    states[bufnr] = state
  end

  local version = result.version
  if not version then
    version = state.version + 1
  end

  if state.version <= version then
    state.diagnostics[client_id] = diagnostics
    state.version = version
  else
    return
  end

  local running = {}
  local all_diagnostics = {}
  for id, ds in pairs(state.diagnostics) do
    if not vim.lsp.client_is_stopped(id) then
      running[id] = ds
      for _, d in ipairs(ds) do
        table.insert(all_diagnostics, d)
      end
    end
  end
  state.diagnostics = running

  set_vritualtext(bufnr, all_diagnostics, ns)
  set_qflist(bufnr, uri, all_diagnostics)
  vim.lsp.util.buf_diagnostics_signs(bufnr, all_diagnostics)
end

vim.lsp.callbacks['textDocument/references'] = function(_, _, result)
  if not result then
    return
  end

  local args = {}
  for _, v in ipairs(result) do
    table.insert(args, {
      path = vim.uri_to_fname(v.uri),
      line = v.range.start.line + 1,
      col = v.range.start.character + 1,
    })
  end

  local source = {name="position", args=args}
  local sources = {source}
  vim.fn.call('denite#start', {sources, {auto_action="preview", vertical_preview=false}})
end

vim.lsp.callbacks['workspace/symbol'] = function(_, _, result)
  if not result then
    return
  end

  local args = {}
  for _, v in ipairs(result) do
    local kind = vim.lsp.protocol.SymbolKind[v.kind]
    table.insert(args, {
      path = vim.uri_to_fname(v.location.uri),
      line = v.location.range.start.line + 1,
      col = v.location.range.start.character + 1,
      word = string.format('[%s] %s', kind, v.name),
    })
  end

  local source = {name="position", args=args}
  local sources = {source}
  vim.fn.call('denite#start', {sources, {auto_action="preview", vertical_preview=false}})
end

vim.lsp.callbacks['textDocument/documentSymbol'] = function(_, _, result)
  if not result then
    return
  end

  local args = {}
  local path = vim.fn.expand("%:p")
  for _, v in ipairs(result) do
    local kind = vim.lsp.protocol.SymbolKind[v.kind]
    table.insert(args, {
      path = path,
      line = v.selectionRange.start.line + 1,
      col = v.selectionRange.start.character + 1,
      word = string.format('[%s] %s %s', kind, v.name, v.detail),
    })
  end

  local source = {name="position", args=args}
  local sources = {source}
  vim.fn.call('denite#start', {sources, {auto_action="preview", vertical_preview=false}})
end
