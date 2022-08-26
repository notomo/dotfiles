vim.cmd.packadd([[optpack.nvim]])
local optpack = require("optpack")

local with_trace = function(f)
  return function()
    local ok, result = xpcall(f, debug.traceback)
    if not ok then
      error(result)
    end
  end
end

local luafile = function(path)
  return with_trace(function()
    vim.cmd.luafile(path)
  end)
end

local mypack = {
  add = function(full_name, opts)
    return optpack.add(
      full_name,
      vim.tbl_deep_extend("force", {
        package_name = "mypack",
        fetch = { depth = 0 },
      }, opts or {})
    )
  end,
}

mypack.add("notomo/optpack.nvim", {
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec]U", function()
        require("optpack").update({
          outputters = {
            echo = { enabled = true },
            log = { enabled = true },
          },
        })
      end)
    end,
  },
})

mypack.add("notomo/vusted")
mypack.add("notomo/virtes.nvim")
mypack.add("notomo/genvdoc", {
  load_on = { modules = { "genvdoc" } },
})

optpack.add("tbastos/vim-lua", {
  load_on = { filetypes = { "lua" } },
  hooks = {
    post_load = function(plugin)
      vim.opt.runtimepath:remove(plugin.directory)
      vim.opt.runtimepath:prepend(plugin.directory)
    end,
  },
})

optpack.add("kana/vim-textobj-user")

optpack.add("kana/vim-submode", {
  load_on = {
    keymaps = function(vim)
      local mappings = {
        { lhs = "l", rhs = "<Esc>gt" },
        { lhs = "s", rhs = "<Cmd>tabr<CR>" },
        { lhs = "e", rhs = "<Cmd>tabl<CR>" },
        { lhs = "a", rhs = "<Esc>gT" },
        { lhs = "h", rhs = "<Esc>gT" },
        { lhs = "q", rhs = "<Esc><Plug>(tabclose_c)" },
        { lhs = "da", rhs = "<Esc><Plug>(tabclose_l)" },
        { lhs = "dl", rhs = "<Esc><Plug>(tabclose_r)" },
        { lhs = "d;", rhs = "<Cmd>+tabclose<CR>" },
        { lhs = "ml", rhs = "<Cmd>tabm+1<CR>" },
        { lhs = "ms", rhs = "<Cmd>tabm 0<CR>" },
        { lhs = "me", rhs = "<Cmd>tabm<CR>" },
        { lhs = "ma", rhs = "<Cmd>tabm-1<CR>" },
      }
      for _, m in ipairs(mappings) do
        vim.keymap.set("n", "[tab]" .. m.lhs, function()
          return require("notomo.plugin.submode").setup(m.lhs, mappings)
        end)
      end
    end,
  },
  hooks = {
    pre_load = function()
      vim.g.submode_keep_leaving_key = 1
      vim.g.submode_timeout = 0
    end,
  },
})

optpack.add("thinca/vim-zenspace", {
  load_on = { events = { { "BufReadPre", "*/*" } } },
  hooks = {
    pre_load = function()
      vim.g["zenspace#default_mode"] = "on"
    end,
  },
})

optpack.add("LeafCage/yankround.vim", {
  load_on = {
    keymaps = function(vim)
      vim.g.yankround_use_region_hl = 1
      vim.keymap.set({ "n", "x" }, "p", [[<Plug>(yankround-p)]])
      vim.keymap.set("n", "P", [[<Plug>(yankround-P)]])
      vim.keymap.set("n", "<C-p>", [[<Plug>(yankround-prev)]])
      vim.keymap.set("n", "<C-n>", [[<Plug>(yankround-next)]])
    end,
  },
})

optpack.add("kana/vim-smartword", {
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "n", "x", "o" }, "w", [[<Plug>(smartword-w)]])
      vim.keymap.set({ "n", "x", "o" }, "b", [[<Plug>(smartword-b)]])
      vim.keymap.set({ "n", "x", "o" }, "e", [[<Plug>(smartword-e)]])
    end,
  },
})

optpack.add("lambdalisue/gina.vim", {
  load_on = { cmds = { "Gina*" }, events = { { "BufReadPre", "*/*" } } },
  hooks = {
    post_add = require("notomo.plugin.gina.mapping").setup,
    post_load = luafile("~/dotfiles/vim/lua/notomo/plugin/gina/init.lua"),
  },
})

optpack.add("kana/vim-textobj-entire", {
  depends = { "vim-textobj-user" },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "o", "x" }, "ae", [[<Plug>(textobj-entire-a)]])
      vim.keymap.set({ "o", "x" }, "ie", [[<Plug>(textobj-entire-i)]])
    end,
  },
})

optpack.add("osyo-manga/vim-textobj-blockwise", {
  depends = { "vim-textobj-user" },
  hooks = {
    pre_load = function()
      vim.g.textobj_blockwise_enable_default_key_mapping = 0
    end,
  },
})

optpack.add("kana/vim-textobj-line", {
  depends = { "vim-textobj-user" },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "x", "o" }, "ag", [[<Plug>(textobj-line-a)]])
      vim.keymap.set({ "x", "o" }, "ig", [[<Plug>(textobj-line-i)]])
    end,
  },
})

optpack.add("bkad/CamelCaseMotion", {
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "n", "x", "o" }, "<Leader>w", "<Plug>CamelCaseMotion_w")
      vim.keymap.set({ "n", "x", "o" }, "<Leader>b", "<Plug>CamelCaseMotion_b")
      vim.keymap.set({ "n", "x", "o" }, "<Leader>e", "<Plug>CamelCaseMotion_e")
    end,
  },
})

optpack.add("osyo-manga/vim-textobj-from_regexp", {
  depends = { "vim-textobj-user" },
  load_on = {
    keymaps = function(vim)
      local opts = { expr = true, replace_keycodes = false }
      vim.keymap.set({ "o", "x" }, "i.", [[textobj#from_regexp#mapexpr('\.\zs.\{-}\ze\.')]], opts)
      vim.keymap.set({ "o", "x" }, "a.", [[textobj#from_regexp#mapexpr('\..\{-1,}\(\.\)\@=')]], opts)

      vim.keymap.set({ "o", "x" }, "ix", [[textobj#from_regexp#mapexpr('\v\*\zs[^*]+\ze\*')]], opts)
      vim.keymap.set({ "o", "x" }, "ax", [[textobj#from_regexp#mapexpr('\*.\{-1,}\(*\)\@=')]], opts)

      vim.keymap.set({ "o", "x" }, "i/", [[textobj#from_regexp#mapexpr('/\zs.\{-}\ze/')]], opts)
      vim.keymap.set({ "o", "x" }, "a/", [[textobj#from_regexp#mapexpr('/.\{-1,}\(/\)\@=')]], opts)
    end,
  },
})

optpack.add("haya14busa/vim-edgemotion", {
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "n", "x", "o" }, "gJ", "<Cmd>normal! m'<CR><Plug>(edgemotion-j)")
      vim.keymap.set({ "n", "x", "o" }, "gK", "<Cmd>normal! m'<CR><Plug>(edgemotion-k)")
    end,
  },
})

optpack.add("mhinz/vim-signify", {
  load_on = { events = { { "BufReadPre", "*/*" } } },
  hooks = { pre_load = luafile("~/dotfiles/vim/lua/notomo/plugin/signify.lua") },
})

optpack.add("junegunn/vim-emoji", { load_on = { modules = { "thetto" } } })

optpack.add("lambdalisue/suda.vim", {
  enabled = vim.fn.has("unix") == 1,
  load_on = { events = { { "BufReadPre", "*/*" } } },
  hooks = {
    pre_load = function()
      vim.keymap.set("n", "[file]W", [[<Cmd>write suda://%<CR>]])
    end,
  },
})

optpack.add("voldikss/vim-translator", {
  load_on = {
    keymaps = function(vim)
      vim.keymap.set("n", "[keyword]T", [[<Cmd>Translate<CR>]])
      vim.keymap.set("x", "T", [[<Plug>TranslateV]])
    end,
  },
  hooks = {
    pre_load = function()
      vim.g.translator_target_lang = "ja"
      vim.g.translator_default_engines = { "google" }
      vim.g.translator_history_enable = 1
    end,
  },
})

mypack.add("notomo/wintablib.nvim", {
  load_on = { modules = { "wintablib" } },
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/wintablib.lua") },
})

mypack.add("notomo/lreload.nvim", {
  load_on = { modules = { "lreload" }, events = { "BufWritePre" } },
  hooks = {
    post_load = function()
      dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/plugin/lreload.lua"))
    end,
  },
})

optpack.add("hrsh7th/nvim-cmp", {
  load_on = { modules = { "cmp" }, events = { "InsertEnter" } },
  hooks = {
    post_load = vim.schedule_wrap(function()
      vim.cmd.runtime({ args = { "after/plugin/cmp_*.lua" }, bang = true })
      require("notomo.plugin.cmp").setup()
    end),
  },
})
optpack.add("hrsh7th/cmp-nvim-lsp", { load_on = { events = { "InsertEnter" }, modules = { "cmp_nvim_lsp" } } })
optpack.add("hrsh7th/cmp-buffer", { load_on = { events = { "InsertEnter" } } })
optpack.add("hrsh7th/cmp-path", { load_on = { events = { "InsertEnter" } } })
optpack.add("hrsh7th/cmp-nvim-lua", { load_on = { events = { "InsertEnter" } } })
mypack.add("notomo/cmp-neosnippet", { load_on = { events = { "InsertEnter" } } })
optpack.add("ray-x/lsp_signature.nvim", { load_on = { modules = { "lsp_signature" }, events = { "InsertEnter" } } })
optpack.add("xiyaowong/coc-sumneko-lua") -- for types

mypack.add("notomo/searcho.nvim", {
  load_on = { modules = { "searcho" } },
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/searcho.lua") },
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
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/open-browser.lua") },
})

mypack.add("notomo/vimonga", {
  load_on = { cmds = { "Vimonga*" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec]v", [[<Cmd>Vimonga database.list -open=tab<CR>]])
    end,
    pre_load = luafile("~/dotfiles/vim/lua/notomo/plugin/vimonga.lua"),
  },
})

mypack.add("notomo/curstr.nvim", {
  load_on = { modules = { "curstr" } },
  hooks = {
    post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/curstr/mapping.lua"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/plugin/curstr/init.lua"),
  },
})

mypack.add("notomo/nvimtool", {
  depends = { "nvim-treesitter" },
  load_on = { modules = { "nvimtool" } },
})

mypack.add("notomo/piemenu.nvim", {
  load_on = { modules = { "piemenu" } },
  hooks = {
    post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/piemenu/mapping.lua"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/plugin/piemenu/init.lua"),
  },
})

mypack.add("notomo/gesture.nvim", {
  load_on = { modules = { "gesture" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "<LeftDrag>", [[<Cmd>lua require("gesture").draw()<CR>]], { silent = true })
      vim.keymap.set("i", "<LeftDrag>", [[<ESC><Cmd>lua require("gesture").draw()<CR>]], { silent = true })
      vim.keymap.set("n", "<LeftRelease>", [[<Cmd>lua require("gesture").finish()<CR>]], { silent = true })
    end,
    post_load = luafile("~/dotfiles/vim/lua/notomo/plugin/gesture.lua"),
  },
})

mypack.add("notomo/flompt.nvim", {
  load_on = { modules = { "flompt" } },
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/flompt.lua") },
})

mypack.add("notomo/thetto.nvim", {
  depends = { "nvim-treesitter" },
  load_on = { modules = { "thetto" }, events = { { "BufReadPost", "*/*" } } },
  hooks = {
    post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/thetto/mapping.lua"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/plugin/thetto/init.lua"),
  },
})

optpack.add("neovim/nvim-lspconfig", {
  load_on = { events = { "FileType" } },
  hooks = {
    post_load = function()
      require("notomo.lsp.handler")
      luafile("~/dotfiles/vim/lua/notomo/plugin/nvim-lspconfig.lua")()
      vim.cmd.edit({ mods = { silent = true, emsg_silent = true } }) -- restart
    end,
  },
})

mypack.add("notomo/kivi.nvim", {
  load_on = { modules = { "kivi" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec]f", [[<Cmd>lua require("kivi").open({layout = {type = "vertical"}})<CR>]])
    end,
    pre_load = luafile("~/dotfiles/vim/lua/notomo/plugin/kivi.lua"),
  },
})

mypack.add("notomo/reacher.nvim", {
  load_on = { modules = { "reacher" } },
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/reacher.lua") },
})

optpack.add("dart-lang/dart-vim-plugin", { load_on = { filetypes = { "dart" } } })

mypack.add("notomo/cmdbuf.nvim", {
  load_on = { modules = { "cmdbuf" } },
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/cmdbuf.lua") },
})

mypack.add("notomo/filetypext.nvim", {
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

mypack.add("notomo/cmdhndlr.nvim", {
  load_on = { modules = { "cmdhndlr" } },
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/cmdhndlr.lua") },
})

mypack.add("notomo/suball.nvim", {
  load_on = { modules = { "suball" } },
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/suball.lua") },
})

optpack.add("nvim-treesitter/nvim-treesitter", {
  load_on = { cmds = { "TS*" }, modules = { "nvim-treesitter" } },
})
optpack.add("nvim-treesitter/nvim-treesitter-textobjects", {
  depends = { "nvim-treesitter" },
  load_on = { cmds = { "TS*" }, modules = { "nvim-treesitter.textobjects" } },
  hooks = {
    post_load = function()
      require("notomo.plugin.treesitter").setup()
    end,
  },
})

mypack.add("notomo/aliaser.nvim", {
  load_on = { modules = { "aliaser" } },
  hooks = { post_load = luafile("~/dotfiles/vim/lua/notomo/plugin/aliaser.lua") },
})

optpack.add("kana/vim-operator-user")

optpack.add("osyo-manga/vim-textobj-multiblock", {
  depends = { "vim-textobj-user" },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "o", "x" }, "aj", [[<Plug>(textobj-multiblock-a)]])
      vim.keymap.set({ "o", "x" }, "ij", [[<Plug>(textobj-multiblock-i)]])
    end,
  },
  hooks = {
    pre_load = function()
      vim.g.textobj_multiblock_no_default_key_mappings = 1
      vim.g.textobj_multiblock_blocks = {
        { "(", ")" },
        { "[", "]" },
        { "{", "}" },
        { "<", ">" },
        { '"', '"' },
        { "'", "'" },
        { "`", "`", 1 },
      }
    end,
  },
})

optpack.add("Shougo/neosnippet.vim", {
  load_on = { events = { "InsertEnter" } },
  hooks = {
    pre_load = luafile("~/dotfiles/vim/lua/notomo/plugin/neosnippet.lua"),
    post_load = function()
      vim.cmd.runtime([[ftdetect/neosnippet.vim]])
    end,
  },
})

optpack.add("osyo-manga/vim-operator-blockwise", {
  depends = { "vim-operator-user", "vim-textobj-blockwise" },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set("n", "[operator]c", [[<Plug>(operator-blockwise-change)]])
      vim.keymap.set("n", "[operator]d", [[<Plug>(operator-blockwise-delete)]])
      vim.keymap.set("n", "[operator]y", [[<Plug>(operator-blockwise-yank)]])
    end,
  },
})

optpack.add("kana/vim-operator-replace", {
  depends = { "vim-operator-user" },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "n", "x", "o" }, "r", [[<Plug>(operator-replace)]])
      vim.keymap.set("o", "<Plug>(builtin-gn)", [[gn]])
      vim.keymap.set("n", "<Plug>(builtin-/)", [[/]])
      vim.keymap.set("n", "<Plug>(builtin-N)", [[N]])
      vim.keymap.set("n", "[edit]n", [[*<Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)]], { remap = true })

      _G._notomo_search = function()
        local tmp = vim.fn.getreg('"')
        vim.cmd.normal({ args = { [[gv""y]] }, bang = true })
        local text = vim.fn.escape(vim.fn.getreg('"'), [[\/]])
        vim.fn.setreg('"', tmp)
        return [[\V]] .. vim.fn.substitute(text, "\n", [[\\n]], "g")
      end

      vim.keymap.set("x", "[edit]n", function()
        return [[<ESC><Plug>(builtin-/)<C-r>=v:lua._notomo_search()<CR><CR><Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)]]
      end, { expr = true, remap = true })
      vim.keymap.set("x", "[edit]d", [["<ESC>/<C-r>=v:lua._notomo_search()<CR><CR>N\"_cgn"]], { expr = true })
    end,
  },
})

optpack.add("rhysd/vim-operator-surround", {
  depends = { "vim-operator-user", "vim-textobj-multiblock" },
  load_on = {
    keymaps = function(vim)
      require("notomo.mapping.util").set_prefix({ "n", "x" }, "surround", "s")

      vim.keymap.set({ "n", "x" }, "[surround]a", [[<Plug>(operator-surround-append)]], { silent = true })
      vim.keymap.set(
        "n",
        "[surround]d",
        [[v<Plug>(textobj-multiblock-a)<Plug>(operator-surround-delete)]],
        { silent = true, remap = true }
      )
      vim.keymap.set("x", "[surround]d", [[<Plug>(operator-surround-delete)]], { silent = true })
      vim.keymap.set(
        "n",
        "[surround]r",
        [[v<Plug>(textobj-multiblock-a)<Plug>(operator-surround-replace)]],
        { silent = true, remap = true }
      )
      vim.keymap.set("x", "[surround]r", [[<Plug>(operator-surround-replace)]], { silent = true })
    end,
  },
  hooks = { pre_load = luafile("~/dotfiles/vim/lua/notomo/plugin/operator-surround.lua") },
})

optpack.add("tpope/vim-repeat")
optpack.add("tyru/caw.vim", {
  depends = { "vim-operator-user", "vim-repeat" },
  load_on = { events = { "FileType" } },
  hooks = { post_add = luafile("~/dotfiles/vim/lua/notomo/plugin/caw.lua") },
})

mypack.add("notomo/promise.nvim", {
  load_on = { modules = { "promise" } },
})

optpack.add("nvim-lua/plenary.nvim", { load_on = { modules = { "plenary" } } })
optpack.add("jose-elias-alvarez/null-ls.nvim", {
  depends = { "plenary.nvim" },
  load_on = { filetypes = { "yaml" }, modules = { "null-ls" } },
  hooks = { post_load = luafile("~/dotfiles/vim/lua/notomo/plugin/null-ls.lua") },
})

mypack.add("notomo/docfilter.nvim", {
  load_on = { modules = { "docfilter" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec]o", [[:<C-u>lua require("docfilter").open("<C-r>+")]])
    end,
  },
})

mypack.add("notomo/stlparts.nvim", {
  load_on = { events = { "VimEnter" } },
  hooks = {
    post_load = function()
      dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/plugin/stlparts.lua"))
    end,
  },
})

optpack.add("romgrk/nvim-treesitter-context", {
  depends = { "nvim-treesitter" },
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

mypack.add("notomo/gettest.nvim", {
  depends = { "nvim-treesitter" },
  load_on = { modules = { "gettest" } },
})

mypack.add("notomo/tracebundler.nvim", {
  load_on = { modules = { "tracebundler" } },
})

optpack.add("mfussenegger/nvim-dap", {
  load_on = { modules = { "dap" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[term]s", [[<Cmd>lua require("dap").step_into()<CR>]])
      vim.keymap.set("n", "[term]b", [[<Cmd>lua require("dap").toggle_breakpoint()<CR>]])
      vim.keymap.set("n", "[term]B", [[<Cmd>lua require("dap").clear_breakpoints()<CR>]])
      vim.keymap.set("n", "[term]n", [[<Cmd>lua require("dap").step_over()<CR>]])
      vim.keymap.set("n", "[term]c", [[<Cmd>lua require("dap").continue()<CR>]])
      vim.keymap.set("n", "[term]f", [[<Cmd>lua require("dap").terminate()<CR>]])
      vim.keymap.set("n", "[keyword]E", [[<Cmd>lua require('dap.ui.widgets').hover()<CR>]])
    end,
    pre_load = function()
      vim.api.nvim_create_augroup("dap_setting", {})
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = "dap_setting",
        pattern = { "dap-float" },
        callback = function()
          vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
        end,
      })
    end,
  },
})
optpack.add("jbyuki/one-small-step-for-vimkind", {
  depends = { "nvim-dap" },
  load_on = { modules = { "osv" } },
  hooks = {
    pre_load = luafile("~/dotfiles/vim/lua/notomo/plugin/one-small-step-for-vimkind.lua"),
  },
})

optpack.add("hashivim/vim-terraform", {
  load_on = { filetypes = { "terraform" } },
})

mypack.add("notomo/vendorlib.nvim", {
  load_on = { modules = { "vendorlib" } },
})

mypack.add("notomo/misclib.nvim", {
  load_on = { modules = { "misclib" } },
})

mypack.add("notomo/importgraph.nvim", {
  load_on = { modules = { "importgraph" } },
})

mypack.add("notomo/ultramarine.nvim", {
  load_on = { events = { "ColorSchemePre" } },
})

optpack.add("norcalli/nvim-colorizer.lua", {
  load_on = { modules = { "colorizer" } },
})
