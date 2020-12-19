vim.api.nvim_command("nnoremap [lc] <Nop>")
vim.api.nvim_command("nmap <Leader>f [lc]")

vim.api.nvim_command("nnoremap <silent> [lc]d <Cmd>lua vim.lsp.buf.definition()<CR>")
vim.api.nvim_command("nnoremap <silent> [lc]k  <Cmd>lua vim.lsp.buf.hover()<CR>")
vim.api.nvim_command("nnoremap <silent> [lc]D <Cmd>lua vim.lsp.buf.type_definition()<CR>")
vim.api.nvim_command("nnoremap <silent> [lc]K  <Cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.api.nvim_command("nnoremap <silent> [lc]s <Cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>")
vim.api.nvim_command("nnoremap <silent> [exec]gr <Cmd>lua vim.lsp.buf.references()<CR>")
vim.api.nvim_command("nnoremap <silent> [exec]gn <Cmd>lua vim.lsp.buf.rename()<CR>")
vim.api.nvim_command("nnoremap <silent> [exec]gd <Cmd>lua vim.lsp.buf.document_symbol()<CR>")
vim.api.nvim_command("nnoremap <silent> [exec]gw <Cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
vim.api.nvim_command("nnoremap <silent> [keyword]c <Cmd>lua vim.lsp.buf.code_action()<CR>")

vim.api.nvim_command("highlight! link LspDiagnosticsError SpellBad")
vim.api.nvim_command("highlight! link LspDiagnosticsWarning Tag")

vim.api.nvim_command("packadd nvim-lspconfig")
local nvimlsp = require("lspconfig")

local try = function(f, ...)
  local ok, result = pcall(f, unpack({...}))
  if not ok then
    vim.api.nvim_err_write("[notomo.lsp]" .. result .. "\n")
  end
end

try(nvimlsp.rls.setup, {})
try(nvimlsp.gopls.setup, {
  init_options = {
    staticcheck = true,
    -- https://staticcheck.io/docs/checks
    analyses = {ST1000 = false},
  },
})
try(nvimlsp.pyls.setup, {})
try(nvimlsp.clangd.setup, {})
try(nvimlsp.tsserver.setup, {})
try(nvimlsp.vimls.setup, {})
try(nvimlsp.cssls.setup, {})
try(nvimlsp.efm.setup, {
  cmd = {"efm-langserver", "-logfile=/tmp/efm.log"},
  -- filetypes = {"vim", "go", "python", "lua", "sh", "typescript.tsx", "typescript"};
  filetypes = {"vim", "go", "python", "lua", "sh"},
  root_dir = function(fname)
    return require("lspconfig/util").root_pattern(".git")(fname) or vim.loop.cwd()
  end,
  on_attach = function(client)
    client.resolved_capabilities.text_document_save = true
    client.resolved_capabilities.text_document_save_include_text = true
  end,
})

vim.lsp.set_log_level("error")

local clear_diagnostics = function(bufnr, ns)
  vim.validate {bufnr = {bufnr, "n", true}}
  local buf = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  vim.fn.setqflist({}, "f")
  vim.fn.sign_unplace("vim_lsp_signs", {buffer = bufnr})
end

local timer = nil
local debounce = function(ms, f)
  if timer == nil then
    timer = vim.loop.new_timer()
  end
  timer:stop()
  timer:start(ms, 0, vim.schedule_wrap(f))
end

local set_vritualtext = function(bufnr, diagnostics, ns)
  for _, v in ipairs(diagnostics) do
    local severity_name = vim.lsp.protocol.DiagnosticSeverity[v.severity]
    local highlight = "LspDiagnostics" .. severity_name

    local pos = v.range.start
    local chunks = {{" " .. v.message:gsub("\r", ""):gsub("\n", "  "), highlight}}
    vim.api.nvim_buf_set_virtual_text(bufnr, ns, pos.line, chunks, {})
  end
end

local set_qflist = function(bufnr, uri, diagnostics)
  local items = {}
  for _, v in ipairs(diagnostics) do
    local pos = v.range.start

    local severity
    if v.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
      severity = "E"
    elseif v.severity == vim.lsp.protocol.DiagnosticSeverity.Warning then
      severity = "W"
    else
      severity = "I"
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
  vim.fn.setqflist({}, "r", {title = "lsp", items = items})
end

local states = {}
local ns = vim.api.nvim_create_namespace("notomo_lsp_diagnostics")

vim.lsp.callbacks["textDocument/publishDiagnostics"] = function(_, _, result, client_id)
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
    state = {diagnostics = {}, version = 0}
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

  debounce(100, function()
    set_vritualtext(bufnr, all_diagnostics, ns)
    set_qflist(bufnr, uri, all_diagnostics)
    vim.lsp.util.buf_diagnostics_signs(bufnr, all_diagnostics)
  end)
end

vim.lsp.callbacks["textDocument/references"] = function(_, _, result)
  if not result or result == {} then
    return
  end
  -- NOTICE: need to be added to runtimepath
  local thetto = require("thetto/entrypoint/command")
  thetto.start({
    source_name = "lsp_adapter/text_document_references",
    opts = {target = "project", auto = "preview"},
    source_opts = {result = result},
  })
end

vim.lsp.callbacks["workspace/symbol"] = function(_, _, result)
  if not result or result == {} then
    return
  end
  local thetto = require("thetto/entrypoint/command")
  thetto.start({
    source_name = "lsp_adapter/workspace_symbol",
    opts = {target = "project", auto = "preview"},
    source_opts = {result = result},
  })
end

vim.lsp.callbacks["textDocument/documentSymbol"] = function(_, _, result)
  if not result or result == {} then
    return
  end
  local thetto = require("thetto/entrypoint/command")
  thetto.start({
    source_name = "lsp_adapter/text_document_document_symbol",
    opts = {auto = "preview"},
    source_opts = {result = result},
  })
end

vim.lsp.callbacks["workspace/configuration"] = function(_, _, _)
  return {}
end
