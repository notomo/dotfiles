local piemenu = require("piemenu")
piemenu.register("default", {
  menus = {
    {
      text = "📖 note",
      action = function()
        require("notomo.lib.edit").note()
      end,
    },
    {
      text = "🔍 finder",
      action = function()
        require("thetto.util.source").start_by_name("thetto/source", { consumer_opts = { ui = { insert = false } } })
      end,
    },
    {
      text = "🔌 plugin",
      action = function()
        require("thetto.util.source").start_by_name("plugin", { consumer_opts = { ui = { insert = false } } })
      end,
    },
    {
      text = "📁 directory",
      action = function()
        require("thetto.util.source").start_by_name("file/directory/recursive", {
          consumer_opts = { ui = { insert = false } },
          cwd = require("thetto.util.cwd").project(),
        })
      end,
    },
    {
      text = "🔖 bookmark",
      action = function()
        require("thetto.util.source").start_by_name("file/bookmark", { consumer_opts = { ui = { insert = false } } })
      end,
    },
    {
      text = "📂 file",
      action = function()
        require("thetto.util.source").start_by_name("file/in_dir", { consumer_opts = { ui = { insert = false } } })
      end,
    },
    {
      text = "👀 mru",
      action = function()
        require("thetto.util.source").start_by_name("file/mru", { consumer_opts = { ui = { insert = false } } })
      end,
    },
    {},
  },
})

piemenu.register("kivi", {
  menus = {
    {
      text = "📖 tab",
      action = function()
        require("kivi").execute("tab_open", { quit = not require("kivi").is_parent() })
      end,
    },
    {
      text = "📖 open",
      action = function()
        require("kivi").execute("child")
      end,
    },
    {
      text = "📖 vsplit",
      action = function()
        require("kivi").execute("vsplit_open", { quit = not require("kivi").is_parent() })
      end,
    },
  },
})

piemenu.register("lsp", {
  menus = {
    {
      text = "👉 definition",
      action = function()
        vim.lsp.buf.definition()
      end,
    },
    {
      text = "👀 hover",
      action = function()
        vim.lsp.buf.hover()
      end,
    },
    {
      text = "🔎 impl",
      action = function()
        vim.lsp.buf.implementation()
      end,
    },
    {
      text = "📚 references",
      action = function()
        vim.lsp.buf.references()
      end,
    },
    {
      text = "📝 paste",
      action = function()
        vim.cmd.normal({ args = { "p" }, bang = true })
      end,
    },
  },
})
