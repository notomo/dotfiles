local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "html",
      },
    }),
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.dart_format,
    null_ls.builtins.formatting.stylua.with({
      extra_args = function(params)
        local config = vim.fn.expand("~/dotfiles/tool/stylua.toml")
        if vim.startswith(params.bufname, vim.fn.expand("~/workspace/neovim/")) then
          config = vim.fn.expand("~/workspace/neovim/.stylua.toml")
        end
        return { "--config-path", config }
      end,
    }),
    null_ls.builtins.formatting.uncrustify.with({
      extra_args = { "-c", vim.fn.expand("~/workspace/neovim/src/uncrustify.cfg") },
      filetypes = { "c" },
    }),
  },
  should_attach = function(bufnr)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if vim.endswith(name, ".yaml") or vim.endswith(name, ".yml") then
      return vim.api.nvim_buf_get_name(bufnr):match("/%.github/workflows/")
    end
    return true
  end,
})
