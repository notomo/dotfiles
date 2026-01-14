local vim = vim

local M = {}

local filetype_servers = {
  lua = { "lua_ls" },
  typescript = { "vtsls", "biome", "denols", "copilot" },
  typescriptreact = { "vtsls", "tailwindcss", "biome", "copilot" },
  css = { "cssls" },
  yaml = { "yamlls" },
  rust = { "rust_analyzer" },
  go = { "gopls", "copilot" },
  python = { "pylsp" },
  json = { "jsonls" },
  prisma = { "prismals" },
  zig = { "zls" },
  astro = { "astro" },
  terraform = { "terraformls", "copilot" },
  graphql = { "graphql" },
  c = { "clangd" },
  ocaml = { "ocamllsp" },
  moonbit = { "moonbit-lsp", "tailwindcss" },
  svelte = { "svelte" },
}

function M.setup(raw_opts)
  if require("misclib.window").is_floating(0) then
    return
  end

  local opts = raw_opts or {}

  local filetype = vim.bo.filetype
  local servers = filetype_servers[filetype] or {}
  local bufnr = vim.api.nvim_get_current_buf()
  for _, name in ipairs(servers) do
    local config = vim.deepcopy(vim.lsp.config[name])
    if type(config.root_dir) == "function" then
      config.root_dir(bufnr, function(root_dir)
        config.root_dir = root_dir
        vim.schedule(function()
          vim.lsp.start(config, {
            silent = true,
            bufnr = bufnr,
            reuse_client = config.reuse_client,
            _root_markers = config.root_markers,
          })
        end)
      end)
    else
      vim.lsp.start(config, {
        silent = true,
        bufnr = bufnr,
        reuse_client = config.reuse_client,
        _root_markers = config.root_markers,
      })
    end
  end

  if vim.tbl_contains(servers, "copilot") then
    vim.lsp.inline_completion.enable(true, { bufnr = 0 })
  end

  require("notomo.lsp.mapping").setup({ symbol_source = opts.symbol_source })
  require("notomo.lsp.navigation").setup()
  require("notomo.lsp.signature_help").setup()
end

return M
