require("curstr").setup({
  groups = {
    directory = {
      opts = {
        after = function(path)
          require("kivi").open({ path = path })
        end,
      },
    },
  },
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
    openable = { names = { "vim/function", "lua", "no_modified_file", "file", "directory", "swagger", "vim/runtime" } },
    no_modified_file = {
      names = { "file/path" },
      opts = {
        modify = function(path)
          return path
        end,
      },
    },
    bool = {
      names = { "togglable/word" },
      opts = {
        words = { "true", "false" },
        normalized = true,
        char_pattern = "[:alnum:]",
      },
    },
    camel_snake = {
      names = { "togglable/pattern" },
      opts = { patterns = { { "\\v_(.)", "\\u\\1" }, { "\\v\\C([A-Z])", "_\\l\\1" } } },
    },
    snake_kebab = {
      names = { "togglable/pattern" },
      opts = { patterns = { { "\\v_(.)", "-\\1" }, { "\\v-(.)", "_\\1" } }, char_pattern = "[:alnum:]_-" },
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
      filetypes = { "javascript", "javascriptreact" },
    },
    print_ts = {
      names = { "togglable/pattern" },
      opts = {
        patterns = { { "\\v^(\\s*)(let\\s+|const\\s+)?([^=[:space:],:]*).*$", "\\1console.log(\\3)" } },
      },
      filetypes = { "typescript", "typescriptreact", "astro" },
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
        patterns = { { "\\v^(\\s*)(local\\s+)?([^=[:space:],]*).*$", "\\1vim.print(\\3)" } },
      },
      filetypes = { "lua" },
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
      },
      opts = { is_line = true },
    },
  },
  sources = {
    ["vim/autoload_function"] = {
      opts = { include_packpath = true },
      filetypes = { "vim", "python", "lua" },
    },
    ["vim/lua"] = {
      filetypes = { "vim", "lua", "cmdhndlr", "make" },
    },
  },
})
