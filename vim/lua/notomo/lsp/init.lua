local vim = vim

local M = {}

local filetype_servers = {
  lua = { "lua_ls" },
  typescript = { "vtsls", "tailwindcss", "biome", "denols" },
  css = { "cssls" },
  yaml = { "yamlls" },
  rust = { "rust_analyzer" },
  go = { "gopls" },
  python = { "pylsp" },
  json = { "jsonls" },
  prisma = { "prismals" },
  zig = { "zls" },
  astro = { "astro" },
  terraform = { "terraformls" },
  graphql = { "graphql" },
  c = { "clangd" },
  ocaml = { "ocamllsp" },
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
          vim.lsp.start(config, { silent = true })
        end)
      end)
    else
      vim.lsp.start(config, { silent = true })
    end
  end

  require("notomo.lsp.mapping").setup({ symbol_source = opts.symbol_source })
  require("notomo.lsp.navigation").setup()
  require("notomo.lsp.signature_help").setup()
end

return M
