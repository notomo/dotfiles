local lspconfig = require("lspconfig")
require("neodev").setup({})

local on_attach = function(client, bufnr)
  vim.lsp.semantic_tokens.stop(bufnr, client.id)
  client.server_capabilities.semanticTokensProvider = nil
end

local setup_ls = function(ls, config, ...)
  for _, disabled_feature in ipairs({ ... }) do
    if vim.fn.has(disabled_feature) == 1 then
      return
    end
  end
  config = config or {}
  config.flags = config.flags or {}
  config.flags.debounce_text_changes = config.flags.debounce_text_changes or 200
  config.capabilities = require("cmp_nvim_lsp").default_capabilities()
  config.capabilities.snippetSupport = false
  config.on_attach = on_attach
  ls.setup(config)
end

setup_ls(lspconfig.rust_analyzer, {
  cmd = {
    "rustup",
    "run",
    "nightly",
    "rust-analyzer",
  },
})

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
        disable = {
          "need-check-nil", -- HACK: return tbl, err
          "param-type-mismatch",
          "cast-type-mismatch",
          "return-type-mismatch",
          "cast-local-type",
        },
      },
      completion = { callSnippet = "Disable", keywordSnippet = "Disable" },
      semantic = { enable = false },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
}, "mac", "win32")
setup_ls(lspconfig.pylsp, {})
setup_ls(lspconfig.clangd, {})
setup_ls(lspconfig.eslint, {
  filetypes = { "javascript" },
})

local deno_pattern = { "deno.json", "deno.jsonc", "denops" }
setup_ls(lspconfig.tsserver, {
  root_dir = function(fname)
    if fname:find("deno:") then
      return nil
    end
    local is_deno = require("lspconfig/util").root_pattern(unpack(deno_pattern))(fname)
    if is_deno then
      return nil
    end
    return require("lspconfig/util").root_pattern("tsconfig.json")(fname)
      or require("lspconfig/util").root_pattern("package.json", "jsconfig.json", ".git")(fname)
      or vim.loop.cwd()
  end,
})

setup_ls(lspconfig.denols, {
  root_dir = require("lspconfig/util").root_pattern(unpack(deno_pattern)),
  before_init = function(config)
    local import_map = config.rootPath .. "/import_map.json"
    if vim.fn.filereadable(import_map) ~= 1 then
      return
    end
    config.initializationOptions["importMap"] = import_map
  end,
}, "mac", "win32")

setup_ls(lspconfig.vimls, {}, "mac", "win32")
setup_ls(lspconfig.cssls, {}, "mac", "win32")

setup_ls(lspconfig.yamlls, {})
setup_ls(lspconfig.autohotkey2, {}, "unix")

setup_ls(lspconfig.ocamllsp, {}, "mac", "win32")

require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "solid",
  },
  hint_enable = false,
})
