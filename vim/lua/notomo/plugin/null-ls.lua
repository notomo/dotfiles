local null_ls = require("null-ls")
null_ls.setup({
  debug = false,
  sources = {
    null_ls.builtins.diagnostics.actionlint,
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
        local upward = vim.fs.find("stylua.toml", {
          upward = true,
          stop = vim.uv.os_homedir(),
          path = vim.fs.dirname(params.bufname),
          type = "file",
          limit = 1,
        })[1]
        if upward then
          return { "--config-path", upward }
        end

        local workflow = require("optpack").get("workflow")
        local default = vim.fs.joinpath(workflow.directory, "stylua.toml")
        return { "--config-path", default }
      end,
    }),
    null_ls.builtins.formatting.uncrustify.with({
      extra_args = { "-c", vim.fn.expand("~/workspace/neovim/src/uncrustify.cfg") },
      filetypes = { "c" },
    }),
  },
})
