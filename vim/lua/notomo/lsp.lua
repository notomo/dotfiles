vim.cmd([[
nnoremap [lc] <Nop>
nmap <Leader>f [lc]

nnoremap <silent> [lc]d <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> [lc]k  <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> [lc]D <Cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> [lc]K  <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> [lc]s <Cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>
nnoremap <silent> [exec]gr <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> [exec]gn <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> [exec]gd <Cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> [exec]gw <Cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> [keyword]c <Cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> [exec]gi <Cmd>lua vim.lsp.buf.implementation()<CR>

highlight! link DiagnosticError SpellBad
highlight! link DiagnosticWarn Tag
]])

local nvimlsp = require("lspconfig")

local setup_ls = function(ls, config, ...)
  for _, disabled_feature in ipairs({ ... }) do
    if vim.fn.has(disabled_feature) == 1 then
      return
    end
  end
  config = config or {}
  config.flags = config.flags or {}
  config.flags.debounce_text_changes = config.flags.debounce_text_changes or 200
  config.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities(), {
    snippetSupport = false,
  })
  ls.setup(config)
end

setup_ls(nvimlsp.rls, {})
setup_ls(nvimlsp.gopls, {
  init_options = {
    staticcheck = true,
    -- https://staticcheck.io/docs/checks
    analyses = { ST1000 = false },
    -- codelenses = {test = true},
  },
})
setup_ls(nvimlsp.sumneko_lua, {
  cmd = {
    vim.env.HOME .. "/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
    vim.env.HOME .. "/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/main.lua",
    "-E",
  },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      diagnostics = {
        enable = true,
        globals = {
          "vim",
          "it",
          "describe",
          "before_each",
          "after_each",
          "setup",
          "lazy_setup",
          "teardown",
          "lazy_teardown",
          "pending",
          "newproxy",
        },
        -- disable = {"lowercase-global"},
      },
      completion = { callSnippet = "Disable", keywordSnippet = "Disable" },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
      telemetry = { enable = false },
    },
  },
}, "mac", "win32")
setup_ls(nvimlsp.pylsp, {})
setup_ls(nvimlsp.clangd, {})
setup_ls(nvimlsp.tsserver, {})
setup_ls(nvimlsp.vimls, {}, "mac", "win32")
setup_ls(nvimlsp.cssls, {}, "mac", "win32")
setup_ls(nvimlsp.dartls, {
  root_dir = require("lspconfig/util").root_pattern("pubspec.yaml", ".git"),
  cmd = {
    "dart",
    vim.fn.expand("~/app/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot"),
    "--lsp",
  },
  init_options = { flutterOutline = true, outline = true },
}, "mac", "win32")
setup_ls(nvimlsp.efm, {
  cmd = { "efm-langserver", "-logfile=/tmp/efm.log" },
  -- filetypes = {"vim", "python", "lua", "sh", "typescript.tsx", "typescript"};
  filetypes = { "vim", "python", "sh" },
  root_dir = function(fname)
    return require("lspconfig/util").find_git_ancestor(fname) or vim.loop.cwd()
  end,
  on_attach = function(client)
    client.resolved_capabilities.text_document_save = true
    client.resolved_capabilities.text_document_save_include_text = true
  end,
})
setup_ls(nvimlsp.yamlls, {})

vim.lsp.set_log_level("error")

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
  vim.diagnostic.setloclist({
    open = false,
    namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id),
  })
end

vim.lsp.handlers["textDocument/references"] = function(_, result)
  if not result or result == {} then
    return
  end
  require("thetto").start("lsp_adapter/text_document_references", {
    opts = { target = "project", auto = "preview" },
    source_opts = { result = result },
  })
end

vim.lsp.handlers["workspace/symbol"] = function(_, result)
  if not result or result == {} then
    return
  end
  require("thetto").start("lsp_adapter/workspace_symbol", {
    opts = { target = "project", auto = "preview" },
    source_opts = { result = result },
  })
end

vim.lsp.handlers["textDocument/documentSymbol"] = function(_, result)
  if not result or result == {} then
    return
  end
  require("thetto").start("lsp_adapter/text_document_document_symbol", {
    opts = { auto = "preview" },
    source_opts = { result = result },
  })
end

vim.lsp.handlers["textDocument/implementation"] = function(_, result)
  if not result or result == {} then
    return
  end
  require("thetto").start("lsp_adapter/text_document_implementation", {
    opts = { target = "project", auto = "preview" },
    source_opts = { result = result },
  })
end

vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end

  local util = vim.lsp.util
  if vim.tbl_islist(result) then
    util.jump_to_location(result[1])
    if #result > 1 then
      vim.fn.setloclist(0, util.locations_to_items(result))
    end
  else
    util.jump_to_location(result)
  end
end

vim.lsp.handlers["dart/textDocument/publishOutline"] = function(_, result, ctx)
  vim.api.nvim_buf_set_var(ctx.bufnr, "_thetto_dart_outline", result)
end

vim.lsp.handlers["dart/textDocument/publishFlutterOutline"] = function(_, result, ctx)
  vim.api.nvim_buf_set_var(ctx.bufnr, "_thetto_flutter_outline", result)
end

_G._notomo_progress = function()
  local messages = vim.lsp.util.get_progress_messages()
  for _, msg in ipairs(messages) do
    print(("[%s] %s"):format(msg.name, msg.message))
  end
end

vim.cmd([[
augroup notomo_lsp_progress
  autocmd!
  autocmd User LspProgressUpdate lua _G._notomo_progress()
augroup END
]])
