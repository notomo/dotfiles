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
vim.api.nvim_command("nnoremap <silent> [exec]gi <Cmd>lua vim.lsp.buf.implementation()<CR>")

vim.api.nvim_command("highlight! link LspDiagnosticsError SpellBad")
vim.api.nvim_command("highlight! link LspDiagnosticsWarning Tag")

local nvimlsp = require("lspconfig")

local setup_ls = function(ls, config, ...)
  for _, disabled_feature in ipairs({...}) do
    if vim.fn.has(disabled_feature) == 1 then
      return
    end
  end
  ls.setup(config or {})
end

setup_ls(nvimlsp.rls, {})
setup_ls(nvimlsp.gopls, {
  init_options = {
    staticcheck = true,
    -- https://staticcheck.io/docs/checks
    analyses = {ST1000 = false},
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
      runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
      diagnostics = {
        enable = true,
        globals = {"vim", "it", "describe", "before_each", "after_each", "pending"},
        -- disable = {"lowercase-global"},
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
}, "mac", "win32")
setup_ls(nvimlsp.pyls, {})
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
}, "mac", "win32")
setup_ls(nvimlsp.efm, {
  cmd = {"efm-langserver", "-logfile=/tmp/efm.log"},
  -- filetypes = {"vim", "go", "python", "lua", "sh", "typescript.tsx", "typescript"};
  filetypes = {"vim", "go", "python", "sh"},
  root_dir = function(fname)
    return require("lspconfig/util").find_git_ancestor(fname) or vim.loop.cwd()
  end,
  on_attach = function(client)
    client.resolved_capabilities.text_document_save = true
    client.resolved_capabilities.text_document_save_include_text = true
  end,
})

vim.lsp.set_log_level("error")

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, method, result, client_id, bufnr, config)
  vim.lsp.diagnostic.on_publish_diagnostics(err, method, result, client_id, bufnr, config)
  vim.lsp.diagnostic.set_loclist({open_loclist = false, client_id = client_id})
end

vim.lsp.handlers["textDocument/references"] = function(_, _, result)
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

vim.lsp.handlers["workspace/symbol"] = function(_, _, result)
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

vim.lsp.handlers["textDocument/documentSymbol"] = function(_, _, result)
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

-- vim.lsp.handlers["workspace/configuration"] = function(_, _, _)
--   return {}
-- end

vim.lsp.handlers["textDocument/definition"] = function(_, _, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end

  local util = vim.lsp.util
  if vim.tbl_islist(result) then
    util.jump_to_location(result[1])
    if #result > 1 then
      util.set_loclist(util.locations_to_items(result))
    end
  else
    util.jump_to_location(result)
  end
end
