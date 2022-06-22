local lspconfig = require("lspconfig")

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

setup_ls(lspconfig.rls, {})
setup_ls(lspconfig.gopls, {
  init_options = {
    staticcheck = true,
    -- https://staticcheck.io/docs/checks
    analyses = { ST1000 = false },
    -- codelenses = {test = true},
  },
})
setup_ls(lspconfig.sumneko_lua, {
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
          [require("optpack").get("coc-sumneko-lua").directory .. "/nvim_lua_types"] = true,
        },
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
      telemetry = { enable = false },
    },
  },
}, "mac", "win32")
setup_ls(lspconfig.pylsp, {})
setup_ls(lspconfig.clangd, {})
setup_ls(lspconfig.eslint, {
  filetypes = { "javascript" },
})
setup_ls(lspconfig.tsserver, {
  root_dir = function(fname)
    local denops = require("lspconfig/util").root_pattern("denops")(fname)
    if denops then
      return nil
    end
    return require("lspconfig/util").root_pattern("tsconfig.json")(fname)
      or require("lspconfig/util").root_pattern("package.json", "jsconfig.json", ".git")(fname)
      or vim.loop.cwd()
  end,
})
setup_ls(lspconfig.denols, {
  root_dir = require("lspconfig/util").root_pattern("deno.json", "deno.jsonc", "denops"),
}, "mac", "win32")
setup_ls(lspconfig.vimls, {}, "mac", "win32")
setup_ls(lspconfig.cssls, {}, "mac", "win32")
setup_ls(lspconfig.dartls, {
  root_dir = require("lspconfig/util").root_pattern("pubspec.yaml", ".git"),
  cmd = {
    "dart",
    vim.fn.expand("~/app/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot"),
    "--lsp",
  },
  init_options = { flutterOutline = true, outline = true },
}, "mac", "win32")
setup_ls(lspconfig.efm, {
  cmd = { "efm-langserver", "-logfile=/tmp/efm.log" },
  -- filetypes = {"vim", "python", "lua", "sh", "typescript.tsx", "typescript"};
  filetypes = { "python", "sh" },
  root_dir = function(fname)
    return require("lspconfig/util").find_git_ancestor(fname) or vim.loop.cwd()
  end,
  on_attach = function(client)
    client.server_capabilities.text_document_save = true
    client.server_capabilities.text_document_save_include_text = true
  end,
})
setup_ls(lspconfig.yamlls, {})
setup_ls(lspconfig.autohotkey2, {}, "unix")

require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "solid",
  },
  hint_enable = false,
})
