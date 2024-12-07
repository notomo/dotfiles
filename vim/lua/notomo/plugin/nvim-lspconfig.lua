---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.semantic_tokens.start = function() end

local lspconfig = require("lspconfig")

local setup_ls = function(ls, config, enable_features)
  enable_features = enable_features or { "linux" }
  local ok = #vim
    .iter(enable_features)
    :filter(function(feature)
      return vim.fn.has(feature) == 1
    end)
    :totable() > 0
  if not ok then
    return
  end

  config = config or {}
  config.flags = config.flags or {}
  config.flags.debounce_text_changes = config.flags.debounce_text_changes or 200
  config.capabilities = require("cmp_nvim_lsp").default_capabilities()
  config.capabilities = vim.tbl_deep_extend("force", config.capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false,
      },
    },
  })
  local on_attach = config.on_attach or function() end
  config.on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    require("notomo.lsp.navigation").attach(client, bufnr)
  end
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
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
        },
      },
    },
  },
  init_options = {
    staticcheck = true,
    -- https://staticcheck.io/docs/checks
    analyses = { ST1000 = false },
    -- codelenses = {test = true},
  },
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}, { "unix" })

setup_ls(lspconfig.lua_ls, {
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {
          "vim",
          "require",
          "unpack",
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
        disable = {},
      },
      runtime = {
        version = "LuaJIT",
      },
      completion = { callSnippet = "Disable", keywordSnippet = "Disable" },
      semantic = { enable = false },
      hint = { enable = true },
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luaassert/library",
        },
      },
    },
  },
})
setup_ls(lspconfig.pylsp, {}, { "unix" })
setup_ls(lspconfig.clangd)
setup_ls(lspconfig.eslint, {}, { "unix" })
setup_ls(lspconfig.jsonls, {}, { "unix" })

local deno_pattern = { "deno.json", "deno.jsonc", "denops" }

setup_ls(lspconfig.vtsls, {
  root_dir = function(fname)
    if fname:find("deno:") then
      return nil
    end
    local is_deno = require("lspconfig.util").root_pattern(unpack(deno_pattern))(fname)
    if is_deno then
      return nil
    end
    return require("lspconfig.util").root_pattern("tsconfig.json")(fname)
      or require("lspconfig.util").root_pattern("package.json", "jsconfig.json", ".git")(fname)
      or vim.uv.cwd()
  end,
  single_file_support = false,
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
    },
  },
  settings = {
    typescript = {
      updateImportsOnFileMove = "always",
    },
    javascript = {
      updateImportsOnFileMove = "always",
    },
    vtsls = {
      enableMoveToFileCodeAction = true,
    },
  },
}, { "unix" })

setup_ls(lspconfig.denols, {
  root_dir = require("lspconfig.util").root_pattern(unpack(deno_pattern)),
  before_init = function(config)
    local import_map = vim.fs.joinpath(config.rootPath, "import_map.json")
    if vim.fn.filereadable(import_map) ~= 1 then
      return
    end
    config.initializationOptions["importMap"] = import_map
  end,
}, { "unix" })

setup_ls(lspconfig.biome, {
  cmd = { "npx", "biome", "lsp-proxy" },
}, { "unix" })

setup_ls(lspconfig.cssls, {}, { "unix" })
setup_ls(lspconfig.yamlls, {}, { "unix" })
setup_ls(lspconfig.flux_lsp, {}, { "unix" })
setup_ls(lspconfig.autohotkey2, {}, { "win32" })
setup_ls(lspconfig.graphql, {}, { "unix" })
setup_ls(lspconfig.ocamllsp, {
  root_dir = require("lspconfig.util").root_pattern("*.opam", ".git", "dune-project", ".opam-switch"),
})
setup_ls(lspconfig.terraformls, {}, { "unix" })
setup_ls(lspconfig.prismals, {}, { "unix" })
setup_ls(lspconfig.tailwindcss, {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "([a-zA-Z0-9\\-:]+)" },
        },
      },
    },
  },
}, { "unix" })
setup_ls(lspconfig.zls, {}, { "unix" })
setup_ls(lspconfig.astro, {}, { "unix" })
