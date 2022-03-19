require("lreload").enable("curstr", {
  post_hook = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/curstr.lua"))
  end,
})

require("curstr.action_group.directory").after = function(path)
  require("kivi").open(path)
end

require("curstr").setup({
  source_aliases = {
    swagger = {
      names = { "file/search" },
      opts = {
        source_pattern = "\\v^([^#]*)#(\\/[^/]*)*(\\w+)$",
        result_pattern = "\\1",
        search_pattern = "\\3:",
      },
      filetypes = { "yaml" },
    },
    openable = { names = { "vim/function", "lua", "file", "directory", "swagger", "vim/runtime" } },
    bool = { names = { "togglable/word" }, opts = { words = { "true", "false" }, normalized = true } },
    camel_snake = {
      names = { "togglable/pattern" },
      opts = { patterns = { { "\\v_(.)", "\\u\\1" }, { "\\v\\C([A-Z])", "_\\l\\1" } } },
    },
    togglable = { names = { "bool", "camel_snake" } },
    print_vim = {
      names = { "togglable/pattern" },
      opts = { patterns = { { "\\v^(\\s*)let\\s+([^=[:space:]]*).*$", "\\1echomsg string(\\2)" } } },
      filetypes = { "vim" },
    },
    print_go = {
      names = { "togglable/pattern" },
      opts = { patterns = { { "\\v^(\\s*)([^=[:space:],]*).*$", "\\1fmt.Println(\\2)" } } },
      filetypes = { "go" },
    },
    print_python = {
      names = { "togglable/pattern" },
      opts = { patterns = { { "\\v^(\\s*)([^=[:space:],]*).*$", "\\1print(\\2)" } } },
      filetypes = { "python" },
    },
    print_js = {
      names = { "togglable/pattern" },
      opts = {
        patterns = { { "\\v^(\\s*)(let\\s+|const\\s+)?([^=[:space:],]*).*$", "\\1console.log(\\3)" } },
      },
      filetypes = { "javascript" },
    },
    print_ts = {
      names = { "togglable/pattern" },
      opts = {
        patterns = { { "\\v^(\\s*)(let\\s+|const\\s+)?([^=[:space:],:]*).*$", "\\1console.log(\\3)" } },
      },
      filetypes = { "typescript" },
    },
    print_rust = {
      names = { "togglable/pattern" },
      opts = {
        patterns = {
          { "\\v^(\\s*)let\\s+(mut\\s+)?([^=[:space:],:]*).*$", '\\1println!("{:?}", \\3);' },
        },
      },
      filetypes = { "rust" },
    },
    print_lua = {
      names = { "togglable/pattern" },
      opts = {
        patterns = { { "\\v^(\\s*)(local\\s+)?([^=[:space:],]*).*$", "\\1print(vim.inspect(\\3))" } },
      },
      filetypes = { "lua" },
    },
    print_dart = {
      names = { "togglable/pattern" },
      opts = {
        patterns = {
          { "\\v^(\\s*)(var\\s+|const\\s+|final\\s+)?([^=[:space:],:]*).*$", "\\1print(\\3);" },
        },
      },
      filetypes = { "dart" },
    },
    print = {
      names = {
        "print_vim",
        "print_go",
        "print_python",
        "print_js",
        "print_ts",
        "print_rust",
        "print_lua",
        "print_dart",
      },
      opts = { is_line = true },
    },
  },
  sources = {
    ["vim/autoload_function"] = {
      opts = { include_packpath = true },
      filetypes = { "vim", "python", "lua" },
    },
  },
})
