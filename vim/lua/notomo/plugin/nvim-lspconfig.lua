local vim = vim

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup("notomo.nvim-lspconfig", {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    client.server_capabilities.semanticTokensProvider = nil

    require("notomo.lsp.navigation").attach(client, bufnr)

    if client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, bufnr, { style = "virtual" })
    end
  end,
})

vim.lsp.config("*", {
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          commitCharactersSupport = true,
          deprecatedSupport = true,
          insertReplaceSupport = false,
          insertTextModeSupport = {
            valueSet = { 1, 2 },
          },
          labelDetailsSupport = true,
          preselectSupport = true,
          resolveSupport = {
            properties = { "documentation", "additionalTextEdits", "insertTextFormat", "insertTextMode", "command" },
          },
          snippetSupport = false,
          tagSupport = {
            valueSet = { 1 },
          },
        },
        completionList = {
          itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" },
        },
        contextSupport = true,
        dynamicRegistration = false,
        insertTextMode = 1,
      },
    },
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false,
      },
    },
  },
})

vim.lsp.config("lua_ls", {
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
        disable = {
          "incomplete-signature-doc",
          "different-requires",
        },
        groupFileStatus = {
          await = "Any",
          codestyle = "None",
          conventions = "Any",
          strict = "Any",
          strong = "None",
          ambiguity = "Any",
          duplicate = "Any",
          global = "Any",
          luadoc = "Any",
          redefined = "Any",
          ["type-check"] = "Any",
          unbalanced = "Any",
          unused = "Any",
        },
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
vim.lsp.enable("lua_ls")

local deno_pattern = { "deno.json", "deno.jsonc", "denops" }
vim.lsp.config("vtsls", {
  root_dir = function(bufnr, cb)
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path:find("deno:") then
      return
    end
    local is_deno = vim.fs.root(path, deno_pattern)
    if is_deno then
      return
    end
    local found = vim.fs.root(path, { "tsconfig.json" })
      or vim.fs.root(path, { "package.json", "jsconfig.json", ".git" })
      or vim.uv.cwd()
    cb(found)
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
})
vim.lsp.enable("vtsls")

vim.lsp.config("denols", {
  root_dir = function(bufnr, cb)
    local path = vim.api.nvim_buf_get_name(bufnr)
    local found = vim.fs.root(path, deno_pattern)
    if found then
      cb(found)
    end
  end,
  before_init = function(config)
    local import_map = vim.fs.joinpath(config.rootPath, "import_map.json")
    if vim.fn.filereadable(import_map) ~= 1 then
      return
    end
    config.initializationOptions["importMap"] = import_map
  end,
}, { "unix" })
vim.lsp.enable("denols")

vim.lsp.config("rust_analyzer", {
  cmd = {
    "rustup",
    "run",
    "nightly",
    "rust-analyzer",
  },
})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("gopls", {
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
})
vim.lsp.enable("gopls")

vim.lsp.config("ocamllsp", {
  root_markers = { "*.opam", ".git", "dune-project", ".opam-switch" },
})
vim.lsp.enable("ocamllsp")

vim.lsp.config("tailwindcss", {
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
})
vim.lsp.enable("tailwindcss")

vim.lsp.config("biome", {
  cmd = { "npx", "biome", "lsp-proxy" },
})
vim.lsp.enable("biome")

vim.lsp.enable("pylsp")
vim.lsp.enable("clangd")
vim.lsp.enable("jsonls")
vim.lsp.enable("cssls")
vim.lsp.enable("yamlls")
vim.lsp.enable("flux_lsp")
vim.lsp.enable("graphql")
vim.lsp.enable("terraformls")
vim.lsp.enable("prismals")
vim.lsp.enable("postgres_lsp")
vim.lsp.enable("zls")
vim.lsp.enable("astro")
