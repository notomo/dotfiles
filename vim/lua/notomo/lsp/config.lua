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

    vim.bo[bufnr].omnifunc = nil

    if client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, { bufnr = bufnr }, { style = "virtual" })
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
  cmd = { "lua-language-server" },
  root_markers = { ".git" },
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

local deno_pattern = { "deno.json", "deno.jsonc", "denops" }
vim.lsp.config("vtsls", {
  cmd = { "vtsls", "--stdio" },
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
  init_options = {
    hostInfo = "neovim",
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

vim.lsp.config("denols", {
  cmd = { "deno", "lsp" },
  cmd_env = { NO_COLOR = true },
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
  settings = {
    deno = {
      enable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
          },
        },
      },
    },
  },
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  root_markers = { "go.mod" },
  init_options = {
    staticcheck = true,
    -- https://staticcheck.io/docs/checks
    analyses = {
      ST1000 = false,
      ST1003 = false,
    },
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

vim.lsp.config("ty", {
  cmd = { "ty", "server" },
  root_markers = {
    "pyproject.toml",
    ".git",
  },
})

vim.lsp.config("jsonls", {
  cmd = { "vscode-json-language-server" },
  root_markers = {
    ".git",
  },
  init_options = {
    provideFormatter = true,
  },
})

vim.lsp.config("prismals", {
  cmd = { "prisma-language-server", "--stdio" },
  root_markers = {
    "package.json",
  },
  settings = {
    prisma = {
      prismaFmtBinPath = "",
    },
  },
})

vim.lsp.config("terraformls", {
  cmd = { "terraform-ls", "serve" },
  root_markers = { ".terraform" },
})

local function root_dir_with_package(root_markers, package_names)
  return function(bufnr, cb)
    local path = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(path, root_markers)
    if not root then
      return
    end
    local package_json = vim.fs.joinpath(root, "package.json")
    if vim.fn.filereadable(package_json) ~= 1 then
      return
    end
    local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(package_json), "\n"))
    if not ok or type(decoded) ~= "table" then
      return
    end
    local deps = vim.tbl_extend("force", decoded.dependencies or {}, decoded.devDependencies or {})
    for _, name in ipairs(package_names) do
      if deps[name] then
        cb(root)
        return
      end
    end
  end
end

vim.lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server" },
  root_dir = root_dir_with_package({ ".git" }, { "tailwindcss" }),
  workspace_required = true,
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

vim.lsp.config("biome", {
  cmd = { "npx", "biome", "lsp-proxy" },
  root_dir = root_dir_with_package({ "biome.json", "biome.jsonc" }, { "@biomejs/biome" }),
  workspace_required = true,
})

vim.lsp.config("moonbit-lsp", {
  cmd = { "moonbit-lsp" },
  root_markers = { "moon.mod.json" },
})

vim.api.nvim_create_autocmd({ "LspProgress" }, {
  group = vim.api.nvim_create_augroup("notomo.lsp.progress", {}),
  pattern = { "end" },
  callback = function(args)
    local done_clients = vim.g.notomo_done_clients or {}
    done_clients[tostring(args.data.client_id)] = true
    vim.g.notomo_done_clients = done_clients
    vim.cmd.redrawstatus()
  end,
})

---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function(items, opts, on_choice)
  if opts.kind == "codeaction" and vim.tbl_get(items, 1, 2, "kind") == "refactor.extract" then
    require("notomo.lib.message").info("Executed: " .. items[1][2].title)
    return on_choice(items[1])
  end

  local item_cursor_factory, get_range
  if opts.kind == "codeaction" then
    local current_row = vim.fn.line(".")
    item_cursor_factory = require("thetto.util.item_cursor").search(function(item)
      if not (item.row and item.end_row) then
        return false
      end
      return item.row == current_row or item.end_row == current_row
    end)
    get_range = function(item)
      local range = vim.tbl_get(item, 2, "command", "arguments", 1, "Range") -- gopls
      if not range then
        return nil
      end
      return require("thetto.util.lsp").range(range)
    end
  end

  require("thetto.util.source").start_by_name("vim/select", {
    opts = {
      items = items,
      prompt = opts.prompt,
      format_item = opts.format_item,
      on_choice = on_choice,
      get_range = get_range,
    },
  }, {
    item_cursor_factory = item_cursor_factory,
  })
end

vim.lsp.log.set_level(vim.log.levels.ERROR)
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
})
