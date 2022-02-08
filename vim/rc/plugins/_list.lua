vim.cmd([[packadd optpack.nvim]])
local optpack = require("optpack")

local with_trace = function(f)
  return function()
    local ok, result = xpcall(f, debug.traceback)
    if not ok then
      error(result)
    end
  end
end

local source = function(path)
  return with_trace(function()
    vim.cmd("source " .. path)
  end)
end

local luafile = function(path)
  return with_trace(function()
    vim.cmd("luafile " .. path)
  end)
end

optpack.add("notomo/optpack.nvim", {
  fetch = { depth = 0 },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec]U", [[<Cmd>lua require("optpack").update()<CR>]])
    end,
  },
})

optpack.add("notomo/vusted", { fetch = { depth = 0 } })
optpack.add("notomo/virtes.nvim", { fetch = { depth = 0 } })
optpack.add("notomo/genvdoc", { fetch = { depth = 0 }, load_on = { modules = { "genvdoc" } } })

optpack.add("tbastos/vim-lua", {
  load_on = { filetypes = { "lua" } },
  hooks = {
    post_load = function(plugin)
      vim.opt.runtimepath:remove(plugin.directory)
      vim.opt.runtimepath:prepend(plugin.directory)
    end,
  },
})

optpack.add("kana/vim-textobj-user", { load_on = { events = { "VimEnter" } } })

optpack.add("kana/vim-submode", {
  load_on = { events = { "VimEnter" } },
  hooks = {
    post_add = function()
      vim.g.submode_keep_leaving_key = 1
      vim.g.submode_timeout = 0
    end,
  },
})

optpack.add("thinca/vim-zenspace", {
  load_on = { events = { { "BufReadPre", "*/*" } } },
  hooks = {
    post_add = function()
      vim.g["zenspace#default_mode"] = "on"
    end,
  },
})

optpack.add("LeafCage/yankround.vim", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/dotfiles/vim/rc/plugins/yankround.lua") },
})

optpack.add("kana/vim-smartword", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/dotfiles/vim/rc/plugins/smartword.lua") },
})

optpack.add("rhysd/vim-color-spring-night", {
  load_on = { events = { "ColorSchemePre" } },
  hooks = {
    post_add = function()
      vim.g.spring_night_kill_italic = 1
      vim.g.spring_night_high_contrast = 0
    end,
  },
})

optpack.add("lambdalisue/gina.vim", {
  load_on = { cmds = { "Gina*" }, events = { { "BufReadPre", "*/*" } } },
  hooks = {
    post_add = require("notomo.mapping").gina,
    post_load = source("~/.vim/rc/plugins/gina.vim"),
  },
})

optpack.add("kana/vim-textobj-entire", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/dotfiles/vim/rc/plugins/textobj-entire.lua") },
})

optpack.add("osyo-manga/vim-textobj-blockwise", {
  load_on = {
    events = { "VimEnter" },
  },
  hooks = {
    pre_load = function()
      vim.g.textobj_blockwise_enable_default_key_mapping = 0
    end,
  },
})

optpack.add("kana/vim-textobj-line", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/dotfiles/vim/rc/plugins/textobj-line.lua") },
})

optpack.add("bkad/CamelCaseMotion", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/dotfiles/vim/rc/plugins/camelcasemotion.lua") },
})

optpack.add("osyo-manga/vim-textobj-from_regexp", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/textobj-from_regexp.lua") },
})

optpack.add("haya14busa/vim-edgemotion", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/edgemotion.lua") },
})

optpack.add("mhinz/vim-signify", {
  load_on = { events = { { "BufReadPre", "*/*" } } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/signify.lua") },
})

optpack.add("junegunn/vim-emoji", { load_on = { events = { "VimEnter" } } })

optpack.add("lambdalisue/suda.vim", {
  enabled = vim.fn.has("unix") == 1,
  load_on = { events = { { "BufReadPre", "*/*" } } },
  hooks = {
    post_add = function()
      vim.g.suda_startup = 1
      vim.keymap.set("n", "[file]W", [[<Cmd>write suda://%<CR>]])
    end,
  },
})

optpack.add("w0rp/ale", {
  load_on = { events = { "FileType" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/ale.lua") },
})

optpack.add("voldikss/vim-translator", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/translator.lua") },
})

optpack.add("notomo/wintablib.nvim", {
  fetch = { depth = 0 },
  load_on = { events = { "VimEnter" }, modules = { "wintablib" } },
  hooks = { post_load = luafile("~/.vim/rc/plugins/wintablib.lua") },
})

optpack.add("notomo/lreload.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "lreload" }, events = { "BufWritePre" } },
  hooks = {
    post_load = function()
      require("notomo.lreload")
      require("lreload").enable("optpack", {
        post_hook = function()
          dofile(vim.fn.expand("~/dotfiles/vim/rc/plugins/_list.lua"))
        end,
      })
    end,
  },
})

optpack.add("nanotee/luv-vimdocs", { load_on = { events = { "VimEnter" } } })

optpack.add("hrsh7th/nvim-cmp", {
  load_on = { modules = { "cmp" }, events = { "VimEnter" } },
  hooks = {
    post_load = vim.schedule_wrap(function()
      vim.cmd([[runtime! after/plugin/cmp_*.lua]])
      require("notomo.cmp").setup()
    end),
  },
})
optpack.add("hrsh7th/cmp-nvim-lsp", { load_on = { events = { "VimEnter" }, modules = { "cmp_nvim_lsp" } } })
optpack.add("hrsh7th/cmp-buffer", { load_on = { events = { "VimEnter" } } })
optpack.add("hrsh7th/cmp-path", { load_on = { events = { "VimEnter" } } })
optpack.add("hrsh7th/cmp-nvim-lua", { load_on = { events = { "VimEnter" } } })
optpack.add("notomo/cmp-neosnippet", { load_on = { events = { "VimEnter" } }, fetch = { depth = 0 } })

optpack.add("notomo/searcho.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "searcho" } },
  hooks = { post_add = source("~/.vim/rc/plugins/searcho.vim") },
})

optpack.add("AndrewRadev/linediff.vim", {
  load_on = { cmds = { "Linediff*" } },
  hooks = {
    post_add = function()
      vim.keymap.set("x", "[diff]l", [[:Linediff<CR>]])
    end,
  },
})

optpack.add("tmhedberg/matchit", {
  load_on = { filetypes = { "html", "vim", "sql" } },
  hooks = {
    post_load = function(plugin)
      -- prior than builtin
      vim.opt.runtimepath:remove(plugin.directory)
      vim.opt.runtimepath:prepend(plugin.directory)
    end,
  },
})

optpack.add("thinca/vim-qfreplace", { load_on = { cmds = { "Qfreplace" } } })

optpack.add("tyru/open-browser.vim", {
  load_on = { cmds = { "OpenBrowser*" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/open-browser.lua") },
})

optpack.add("notomo/vimonga", {
  fetch = { depth = 0 },
  load_on = { cmds = { "Vimonga*" } },
  hooks = { post_add = source("~/.vim/rc/plugins/vimonga.vim") },
})

optpack.add("notomo/curstr.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "curstr" } },
  hooks = {
    post_add = luafile("~/.vim/rc/plugins/curstr.lua"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/curstr.lua"),
  },
})

optpack.add("notomo/nvimtool", { load_on = { modules = { "nvimtool" } }, fetch = { depth = 0 } })

optpack.add("notomo/piemenu.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "piemenu" } },
  hooks = {
    post_add = source("~/.vim/rc/plugins/piemenu.vim"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/piemenu.lua"),
  },
})

optpack.add("notomo/gesture.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "gesture" } },
  hooks = {
    post_add = luafile("~/.vim/rc/plugins/gesture.lua"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/gesture.lua"),
  },
})

optpack.add("notomo/flompt.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "flompt" } },
  hooks = { post_add = source("~/.vim/rc/plugins/flompt.vim") },
})

optpack.add("notomo/thetto.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "thetto" }, events = { { "BufReadPost", "*/*" } } },
  hooks = {
    post_add = source("~/.vim/rc/plugins/thetto.vim"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/thetto.lua"),
  },
})

optpack.add("neovim/nvim-lspconfig", {
  load_on = { events = { "FileType" } },
  hooks = {
    post_load = function()
      require("notomo.lsp.handler").setting()
      luafile("~/.vim/rc/plugins/nvim-lspconfig.lua")()
      vim.cmd([[silent! edit]]) -- restart
    end,
  },
})

optpack.add("notomo/kivi.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "kivi" } },
  hooks = { post_add = source("~/.vim/rc/plugins/kivi.vim") },
})

optpack.add("notomo/reacher.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "reacher" } },
  hooks = { post_add = source("~/.vim/rc/plugins/reacher.vim") },
})

optpack.add("dart-lang/dart-vim-plugin", { load_on = { filetypes = { "dart" } } })

optpack.add("notomo/cmdbuf.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "cmdbuf" } },
  hooks = { post_add = source("~/.vim/rc/plugins/cmdbuf.vim") },
})

optpack.add("notomo/filetypext.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "filetypext" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec];", function()
        require("notomo.edit").scratch(
          require("filetypext").detect({ bufnr = 0 })[1],
          vim.bo.filetype ~= "" and vim.bo.filetype or "markdown"
        )
      end)
    end,
  },
})

optpack.add("notomo/cmdhndlr.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "cmdhndlr" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/cmdhndlr.lua") },
})

optpack.add("notomo/suball.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "suball" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/suball.lua") },
})

optpack.add(
  "nvim-treesitter/nvim-treesitter",
  { load_on = { cmds = { "TS*" }, modules = { "gettest", "nvimtool", "nvim-treesitter" } } }
)
optpack.add("nvim-treesitter/nvim-treesitter-textobjects", {
  load_on = { cmds = { "TS*" }, modules = { "nvim-treesitter" } },
  hooks = {
    post_load = function()
      require("notomo.treesitter").setup()
    end,
  },
})

optpack.add("notomo/aliaser.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "aliaser" } },
  hooks = { post_load = luafile("~/dotfiles/vim/lua/notomo/aliaser.lua") },
})

optpack.add("tpope/vim-repeat", { load_on = { events = { "VimEnter" } } })

optpack.add("kana/vim-operator-user", { load_on = { events = { "VimEnter" } } })

optpack.add("osyo-manga/vim-textobj-multiblock", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/dotfiles/vim/rc/plugins/textobj-multiblock.lua") },
})

optpack.add("Shougo/neosnippet.vim", {
  load_on = { events = { "VimEnter" } },
  hooks = {
    post_add = luafile("~/dotfiles/vim/rc/plugins/neosnippet.lua"),
    post_load = function()
      vim.cmd([[runtime ftdetect/neosnippet.vim]])
    end,
  },
})

optpack.add("osyo-manga/vim-operator-blockwise", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/dotfiles/vim/rc/plugins/operator-blockwise.lua") },
})

optpack.add("kana/vim-operator-replace", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/dotfiles/vim/rc/plugins/operator-replace.lua") },
})

optpack.add("rhysd/vim-operator-surround", {
  load_on = { events = { "VimEnter" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/operator-surround.lua") },
})

optpack.add("tyru/caw.vim", {
  load_on = { events = { "FileType" } },
  hooks = { post_add = luafile("~/.vim/rc/plugins/caw.lua") },
})

optpack.add("notomo/promise.nvim", {
  fetch = { depth = 0 },
  enabled = vim.fn.has("unix") == 1,
  load_on = { modules = { "promise" } },
})

optpack.add("nvim-lua/plenary.nvim", { load_on = { modules = { "plenary" } } })
optpack.add("jose-elias-alvarez/null-ls.nvim", {
  load_on = { filetypes = { "yaml" }, modules = { "null-ls" } },
  hooks = { post_load = luafile("~/dotfiles/vim/lua/notomo/null_ls.lua") },
})

optpack.add("notomo/docfilter.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "docfilter" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec]o", [[:<C-u>lua require("docfilter").open("<C-r>+")]])
    end,
  },
})

optpack.add("notomo/stlparts.nvim", {
  fetch = { depth = 0 },
  load_on = { events = { "VimEnter" }, modules = { "stlparts" } },
  hooks = {
    post_load = function()
      require("notomo.stlparts").setup()
    end,
  },
})

optpack.add("romgrk/nvim-treesitter-context", {
  load_on = { cmds = { "TSContext*" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec]x", "<Cmd>TSContextToggle<CR>")
    end,
    post_load = function()
      require("treesitter-context").setup({ enable = false })
    end,
  },
})

optpack.add("notomo/gettest.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "gettest" } },
})

optpack.add("notomo/tracebundler.nvim", {
  fetch = { depth = 0 },
  load_on = { modules = { "tracebundler" } },
})
