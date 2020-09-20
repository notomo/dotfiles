local custom = require("curstr/custom")

custom.source_aliases.swagger = {
  names = {"file/search"},
  opts = {
    source_pattern = "\\v^([^#]*)#(\\/[^/]*)*(\\w+)$",
    result_pattern = "\\1",
    search_pattern = "\\3:",
  },
  filetypes = {"yaml"},
}

custom.sources["vim/autoload_function"] = {
  opts = {include_packpath = true},
  filetypes = {"vim", "python", "lua"},
}

custom.source_aliases.openable = {
  names = {"vim/function", "vim/lua", "file", "directory", "swagger", "vim/runtime"},
}

custom.source_aliases.bool = {
  names = {"togglable/word"},
  opts = {words = {"true", "false"}, normalized = true},
}

custom.source_aliases.camel_snake = {
  names = {"togglable/pattern"},
  opts = {patterns = {{"\\v_(.)", "\\u\\1"}, {"\\v\\C([A-Z])", "_\\l\\1"}}},
}

custom.source_aliases.togglable = {names = {"bool", "camel_snake"}}

custom.source_aliases.print_vim = {
  names = {"togglable/pattern"},
  opts = {patterns = {{"\\v^(\\s*)let\\s+([^=[:space:]]*).*$", "\\1echomsg string(\\2)"}}},
  filetypes = {"vim"},
}

custom.source_aliases.print_go = {
  names = {"togglable/pattern"},
  opts = {patterns = {{"\\v^(\\s*)([^=[:space:],]*).*$", "\\1fmt.Println(\\2)"}}},
  filetypes = {"go"},
}

custom.source_aliases.print_python = {
  names = {"togglable/pattern"},
  opts = {patterns = {{"\\v^(\\s*)([^=[:space:],]*).*$", "\\1print(\\2)"}}},
  filetypes = {"python"},
}

custom.source_aliases.print_js = {
  names = {"togglable/pattern"},
  opts = {
    patterns = {{"\\v^(\\s*)(let\\s+|const\\s+)?([^=[:space:],]*).*$", "\\1console.log(\\3)"}},
  },
  filetypes = {"javascript"},
}

custom.source_aliases.print_ts = {
  names = {"togglable/pattern"},
  opts = {
    patterns = {{"\\v^(\\s*)(let\\s+|const\\s+)?([^=[:space:],:]*).*$", "\\1console.log(\\3)"}},
  },
  filetypes = {"typescript"},
}

custom.source_aliases.print_rust = {
  names = {"togglable/pattern"},
  opts = {
    patterns = {{"\\v^(\\s*)let\\s+(mut\\s+)?([^=[:space:],:]*).*$", "\\1println!(\"{:?}\", \\3);"}},
  },
  filetypes = {"rust"},
}

custom.source_aliases.print_lua = {
  names = {"togglable/pattern"},
  opts = {patterns = {{"\\v^(\\s*)(local\\s+)?([^=[:space:],]*).*$", "\\1print(vim.inspect(\\3))"}}},
  filetypes = {"lua"},
}

custom.source_aliases.print = {
  names = {
    "print_vim",
    "print_go",
    "print_python",
    "print_js",
    "print_ts",
    "print_rust",
    "print_lua",
  },
  opts = {is_line = true},
}
