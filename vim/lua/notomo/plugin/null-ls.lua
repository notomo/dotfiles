local null_ls = require("null-ls")
null_ls.setup({
  debug = false,
  sources = {
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.ltrs.with({
      filetypes = {
        "text",
      },
      -- needs `ltrs docker start`
      args = { "--hostname", "http://localhost", "-p", "8010", "check", "-l", "en", "-m", "-r", "--text", "$TEXT" },
      runtime_condition = function(params)
        return vim.startswith(params.bufname, vim.fn.expand("~/workspace/scratch/text/scratch.txt"))
      end,
    }),
    null_ls.builtins.formatting.ocamlformat.with({
      args = { "--enable-outside-detected-project", "--impl", "-" },
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.deno_fmt.with({
      filetypes = {
        "typescript",
      },
    }),
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "html",
        "graphql",
      },
    }),
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.fixjson.with({
      filetypes = {
        "json",
        "jsonc",
      },
    }),
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.stylua.with({
      extra_args = function(params)
        local config = vim.fn.expand("$DOTFILES/tool/stylua.toml")
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
})
