require("lreload").enable("piemenu", {
  post_hook = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/piemenu.lua"))
  end,
})

local piemenu = require("piemenu")
piemenu.register("default", {
  menus = {
    {
      text = "📖 note",
      action = function()
        require("notomo.edit").note()
      end,
    },
    {
      text = "🔍 finder",
      action = function()
        require("thetto").start("thetto/source", {opts = {insert = false}})
      end,
    },
    {
      text = "🔌 plugin",
      action = function()
        require("thetto").start("plugin", {opts = {insert = false}})
      end,
    },
    {
      text = "📁 directory",
      action = function()
        require("thetto").start("file/directory/recursive", {
          opts = {insert = false, target = "project"},
        })
      end,
    },
    {
      text = "🔖 bookmark",
      action = function()
        require("thetto").start("file/bookmark", {opts = {insert = false}})
      end,
    },
    {
      text = "📂 file",
      action = function()
        require("thetto").start("file/in_dir", {opts = {insert = false}})
      end,
    },
    {
      text = "👀 mru",
      action = function()
        require("thetto").start("file/mru", {opts = {insert = false}})
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
        require("kivi").execute("tab_open", {quit = not require("kivi").is_parent()})
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
        require("kivi").execute("vsplit_open", {quit = not require("kivi").is_parent()})
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
        vim.cmd("normal! p")
      end,
    },
  },
})
