vim.cmd.packadd([[optpack.nvim]])
local optpack = require("optpack")

local require_fn = function(name)
  return function()
    package.loaded[name] = nil
    require(name)
  end
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
      require("optpack").set_default({
        install_or_update = {
          outputters = {
            echo = { enabled = true },
            log = { enabled = true },
          },
        },
      })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("optpack_mapping", {}),
        pattern = { "optpack" },
        callback = function()
          vim.keymap.set("n", "<CR>", function()
            local update = vim.b.optpack_updates[tostring(vim.fn.line("."))]
            if not update then
              return
            end
            require("thetto").start("git/log", {
              source_opts = { args = { update.revision_range } },
              opts = { cwd = update.directory },
            })
          end, { buffer = true })
        end,
      })
      vim.keymap.set("n", "[exec]U", function()
        require("optpack").update({
          outputters = {
            buffer = {
              open = function(bufnr)
                vim.cmd.tabedit()
                vim.bo.buftype = "nofile"
                vim.bo.bufhidden = "wipe"
                vim.cmd.buffer(bufnr)
              end,
            },
          },
        })
      end)
    end,
  },
})

mypack.add("notomo/workflow")
mypack.add("notomo/vusted")
mypack.add("notomo/virtes.nvim")
mypack.add("notomo/genvdoc", {
  load_on = { modules = { "genvdoc" } },
})

optpack.add("kana/vim-textobj-user", {
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "o", "x" }, "aB", [[<Plug>(textobj-codeblock-a)]])
      vim.keymap.set({ "o", "x" }, "iB", [[<Plug>(textobj-codeblock-i)]])
    end,
  },
  hooks = {
    post_load = function()
      vim.fn["textobj#user#plugin"]("codeblock", {
        ["-"] = {
          pattern = { [[\v^\s*```\s?\w*$\n\ze.]], [[\v^\s*```]] },
          ["select-a"] = "aB",
          ["select-i"] = "iB",
        },
      })
    end,
  },
})

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
    cmds = { "Translate*" },
  },
  hooks = {
    post_add = function()
      vim.keymap.set("x", "T", [[:Translate --source_lang=en --target_lang=ja<CR>]])
      vim.keymap.set("x", "<Leader>T", [[:Translate --source_lang=ja --target_lang=en<CR>]])
    end,
    pre_load = function()
      vim.g.translator_target_lang = "ja"
      vim.g.translator_default_engines = { "google" }
      vim.g.translator_history_enable = 1
    end,
  },
})

mypack.add("notomo/wintablib.nvim", {
  load_on = { modules = { "wintablib" } },
  hooks = { post_add = require_fn("notomo.plugin.wintablib") },
})

local enabled_copilot = vim.fn.has("mac") == 1

optpack.add("hrsh7th/nvim-cmp", {
  load_on = { modules = { "cmp" }, events = { "InsertEnter" } },
  hooks = {
    post_load = require("notomo.lib.once").new(
      vim.schedule_wrap(function()
        vim.cmd.runtime({ args = { "after/plugin/cmp_*.lua" }, bang = true })
        if enabled_copilot then
          require("copilot_cmp").setup()
        end
        require("notomo.plugin.cmp").setup()
      end),
      "cmp_setup"
    ),
  },
})
optpack.add("hrsh7th/cmp-nvim-lsp", { load_on = { events = { "InsertEnter" }, modules = { "cmp_nvim_lsp" } } })
optpack.add("hrsh7th/cmp-buffer", { load_on = { events = { "InsertEnter" } } })
optpack.add("hrsh7th/cmp-path", { load_on = { events = { "InsertEnter" } } })
optpack.add("hrsh7th/cmp-nvim-lua", { load_on = { events = { "InsertEnter" } } })
mypack.add("notomo/cmp-neosnippet", { load_on = { events = { "InsertEnter" } } })
optpack.add("ray-x/lsp_signature.nvim", { load_on = { modules = { "lsp_signature" }, events = { "InsertEnter" } } })

optpack.add("zbirenbaum/copilot.lua", {
  enabled = enabled_copilot,
  load_on = { events = { "InsertEnter" } },
})
optpack.add("zbirenbaum/copilot-cmp", {
  enabled = enabled_copilot,
  depends = { "copilot.lua" },
  load_on = { events = { "VimEnter" }, modules = { "copilot_cmp" } },
  hooks = {
    post_load = function()
      require("copilot").setup({
        filetypes = {
          go = true,
          terraform = true,
          yaml = true,
          typescript = true,
          typescriptreact = true,
          ["*"] = false,
        },
      })
      vim.cmd.Copilot("enable")
    end,
  },
})

mypack.add("notomo/searcho.nvim", {
  load_on = {
    modules = { "searcho" },
    keymaps = function(vim)
      vim.keymap.set({ "n", "x" }, "/", [[/\v]])
      vim.keymap.set({ "n", "x" }, "?", [[?\v]])

      vim.keymap.set({ "n", "x" }, "s<Space>j", function()
        return [[/\v]] .. vim.fn.getreg([["]])
      end, { expr = true })
      vim.keymap.set({ "n", "x" }, "s<Space>k", function()
        return [[?\v]] .. vim.fn.getreg([["]])
      end, { expr = true })
    end,
  },
  hooks = {
    post_add = function()
      vim.keymap.set({ "n", "x" }, "n", function()
        return require("searcho").normal("n")
      end, { expr = true })
      vim.keymap.set({ "n", "x" }, "N", function()
        return require("searcho").normal("N")
      end, { expr = true })

      vim.keymap.set({ "n", "x" }, "sj", function()
        local pattern = [[\v]] .. vim.fn.expand("<cword>")
        return require("searcho").forward() .. pattern
      end, { expr = true })
      vim.keymap.set({ "n", "x" }, "sk", function()
        local pattern = [[\v]] .. vim.fn.expand("<cword>")
        return require("searcho").backward() .. pattern
      end, { expr = true })

      local convert = function(word)
        return [[\v<]] .. word .. ">" .. vim.keycode("<Left><Space><BS>")
      end
      vim.keymap.set({ "n", "x" }, "sJ", function()
        local pattern = convert(vim.fn.expand("<cword>"))
        return require("searcho").forward() .. pattern
      end, { expr = true, replace_keycodes = false })
      vim.keymap.set({ "n", "x" }, "sK", function()
        local pattern = convert(vim.fn.expand("<cword>"))
        return require("searcho").backward() .. pattern
      end, { expr = true, replace_keycodes = false })
    end,
    post_load = require_fn("notomo.plugin.searcho"),
  },
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

mypack.add("notomo/curstr.nvim", {
  load_on = { modules = { "curstr" } },
  hooks = {
    post_add = require_fn("notomo.plugin.curstr.mapping"),
    post_load = require_fn("notomo.plugin.curstr"),
  },
})

mypack.add("notomo/piemenu.nvim", {
  load_on = { modules = { "piemenu" } },
  hooks = {
    post_add = require_fn("notomo.plugin.piemenu.mapping"),
    post_load = require_fn("notomo.plugin.piemenu"),
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
    post_load = require_fn("notomo.plugin.gesture"),
  },
})

mypack.add("notomo/thetto.nvim", {
  load_on = { modules = { "thetto" }, events = { { "BufReadPost", "*/*" } } },
  hooks = {
    post_add = require_fn("notomo.plugin.thetto.mapping"),
    post_load = require_fn("notomo.plugin.thetto"),
  },
})

optpack.add("folke/neodev.nvim", {
  load_on = { modules = { "neodev" } },
})
optpack.add("neovim/nvim-lspconfig", {
  load_on = { events = { "FileType" } },
  hooks = {
    post_load = function()
      require("notomo.lsp.handler")
      require("notomo.plugin.nvim-lspconfig")
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
    pre_load = require_fn("notomo.plugin.kivi"),
  },
})

mypack.add("notomo/reacher.nvim", {
  load_on = { modules = { "reacher" } },
  hooks = { post_add = require_fn("notomo.plugin.reacher") },
})

mypack.add("notomo/cmdbuf.nvim", {
  load_on = { modules = { "cmdbuf" } },
  hooks = { post_add = require_fn("notomo.plugin.cmdbuf") },
})

mypack.add("notomo/filetypext.nvim", {
  load_on = { modules = { "filetypext" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec];", function()
        require("notomo.lib.edit").scratch(
          require("filetypext").detect({ bufnr = 0 })[1],
          vim.bo.filetype ~= "" and vim.bo.filetype or "markdown"
        )
      end)
    end,
  },
})

mypack.add("notomo/cmdhndlr.nvim", {
  load_on = {
    modules = { "cmdhndlr" },
    events = { "BufWritePre" },
  },
  hooks = { post_add = require_fn("notomo.plugin.cmdhndlr") },
})

-- should load after cmdhndlr not to clear format autocmd
mypack.add("notomo/lreload.nvim", {
  load_on = { modules = { "lreload" }, events = { "BufWritePre" } },
  hooks = {
    post_load = require_fn("notomo.plugin.lreload"),
  },
})

mypack.add("notomo/suball.nvim", {
  load_on = { modules = { "suball" } },
  hooks = { post_add = require_fn("notomo.plugin.suball") },
})

optpack.add("nvim-treesitter/nvim-treesitter", {
  load_on = {
    cmds = { "TS*" },
    modules = { "nvim-treesitter" },
    events = { "FileType" },
  },
  hooks = {
    post_load = function(plugin)
      -- prior than builtin
      vim.opt.runtimepath:remove(plugin.directory)
      vim.opt.runtimepath:prepend(plugin.directory)
    end,
  },
})
optpack.add("nvim-treesitter/nvim-treesitter-textobjects", {
  depends = { "nvim-treesitter" },
  load_on = { cmds = { "TS*" }, modules = { "nvim-treesitter.textobjects" } },
  hooks = {
    post_load = function()
      require("notomo.plugin.nvim-treesitter").setup()
    end,
  },
})

mypack.add("notomo/aliaser.nvim", {
  load_on = { modules = { "aliaser" } },
  hooks = { post_load = require_fn("notomo.plugin.aliaser") },
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
    pre_load = require_fn("notomo.plugin.neosnippet"),
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
      vim.keymap.set("c", "<Plug>(builtin-CR)", [[<CR>]])
      vim.keymap.set("n", "[edit]n", [[*<Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)]], { remap = true })

      _G._notomo_search = function()
        local tmp = vim.fn.getreg('"')
        vim.cmd.normal({ args = { [[gv""y]] }, bang = true })
        local text = vim.fn.escape(vim.fn.getreg('"'), [[\/]])
        vim.fn.setreg('"', tmp)
        return [[\V]] .. vim.fn.substitute(text, "\n", [[\\n]], "g")
      end

      vim.keymap.set("x", "[edit]n", function()
        return [[<ESC><Plug>(builtin-/)<C-r>=v:lua._notomo_search()<Plug>(builtin-CR)<Plug>(builtin-CR)<Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)]]
      end, { expr = true, remap = true })
      vim.keymap.set("x", "[edit]d", [["<ESC>/<C-r>=v:lua._notomo_search()<CR><CR>N\"_cgn"]], { expr = true })
    end,
  },
})

optpack.add("rhysd/vim-operator-surround", {
  depends = { "vim-operator-user", "vim-textobj-multiblock" },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "n", "x" }, "[surround]", "<Nop>")
      vim.keymap.set({ "n", "x" }, "s", "[surround]", { remap = true })

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
  hooks = { pre_load = require_fn("notomo.plugin.operator-surround") },
})

mypack.add("notomo/promise.nvim", {
  load_on = { modules = { "promise" } },
})

mypack.add("notomo/stlparts.nvim", {
  load_on = { events = { "VimEnter" } },
  hooks = {
    post_load = require_fn("notomo.plugin.stlparts"),
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
  load_on = {
    modules = { "dap" },
    filetypes = { "go" },
  },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[term]s", [[<Cmd>lua require("dap").step_into()<CR>]])
      vim.keymap.set("n", "[term]S", [[<Cmd>lua require("dap").step_out()<CR>]])
      vim.keymap.set("n", "[term]b", [[<Cmd>lua require("dap").toggle_breakpoint()<CR>]])
      vim.keymap.set("n", "[term]B", function()
        vim.ui.input({
          prompt = "Break point condition expr: ",
        }, function(condition)
          if not condition then
            return
          end
          vim.schedule(function()
            require("dap").set_breakpoint(condition)
          end)
        end)
      end)
      vim.keymap.set("n", "[term]n", [[<Cmd>lua require("dap").step_over()<CR>]])
      vim.keymap.set("n", "[term]c", [[<Cmd>lua require("dap").continue()<CR>]])
      vim.keymap.set("n", "[term]C", [[<Cmd>lua require("dap").run_to_cursor()<CR>]])
      vim.keymap.set("n", "[term]R", [[<Cmd>lua require("dap").restart()<CR>]])
      vim.keymap.set("n", "[term]f", function()
        require("nvim-dap-virtual-text.virtual_text").clear_virtual_text()
        require("dap").disconnect()
        require("dap").close()
      end)
      vim.keymap.set("n", "[term]F", [[<Cmd>lua require("dap").clear_breakpoints()<CR>]])
      vim.keymap.set("n", "<CR>", function()
        if not require("dap").session() then
          return "<CR>"
        end
        vim.schedule(function()
          require("dap.ui.widgets").hover()
        end)
        return ""
      end, { expr = true })
    end,
    post_load = require_fn("notomo.plugin.nvim-dap"),
  },
})
optpack.add("theHamsta/nvim-dap-virtual-text", {
  load_on = { modules = { "nvim-dap-virtual-text" } },
})

optpack.add("jbyuki/one-small-step-for-vimkind", {
  depends = { "nvim-dap" },
  load_on = { modules = { "osv" } },
  hooks = {
    pre_load = require_fn("notomo.plugin.one-small-step-for-vimkind"),
  },
})

mypack.add("notomo/vendorlib.nvim", {
  load_on = { modules = { "vendorlib" } },
})

mypack.add("notomo/misclib.nvim", {
  load_on = { modules = { "misclib" } },
})

mypack.add("notomo/importgraph.nvim", {
  depends = { "nvim-treesitter" },
  load_on = { modules = { "importgraph" } },
})

mypack.add("notomo/ultramarine.nvim", {
  hooks = {
    post_add = function(plugin)
      vim.g.notomo_colorscheme = vim.split(plugin.name, ".", { plain = true })[1]
    end,
  },
  load_on = { events = { "ColorSchemePre" } },
})

mypack.add("notomo/hlmsg.nvim", {
  load_on = { modules = { "hlmsg" } },
  hooks = {
    post_add = function()
      vim.keymap.set("n", "[exec]cm", function()
        require("thetto").start("hlmsg")
      end)
    end,
  },
})

mypack.add("notomo/assertlib.nvim", {
  load_on = { modules = { "assertlib" } },
})

mypack.add("notomo/termnavi.nvim", {
  load_on = { modules = { "termnavi" }, events = { { "BufReadPre", "*/*" } } },
  hooks = {
    pre_load = require_fn("notomo.plugin.termnavi"),
  },
})

mypack.add("notomo/listdefined.nvim", {
  load_on = { modules = { "listdefined" } },
})

optpack.add("lewis6991/gitsigns.nvim", {
  load_on = { modules = { "gitsigns" }, events = { { "BufReadPre", "*/*" } } },
  hooks = {
    post_load = require_fn("notomo.plugin.gitsigns"),
  },
})

optpack.add("previm/previm", {
  load_on = { filetypes = { "markdown" } },
  hooks = {
    pre_load = function()
      if vim.fn.has("wsl") == 1 then
        vim.g.previm_open_cmd = "wslview"
      elseif vim.fn.has("mac") == 1 then
        vim.g.previm_open_cmd = "open -a Google\\ Chrome"
      end
      vim.g.previm_enable_realtime = 1
    end,
  },
})

optpack.add("numToStr/Comment.nvim", {
  depends = { "nvim-ts-context-commentstring" },
  load_on = { events = { "FileType" } },
  hooks = {
    post_load = function()
      require("Comment").setup({
        mappings = {
          basic = false,
          extra = false,
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
      vim.keymap.set("n", "<Space>c", "<Plug>(comment_toggle_linewise)_")
      vim.keymap.set("x", "<Space>c", "<Plug>(comment_toggle_linewise_visual)")
    end,
  },
})
optpack.add("JoosepAlviste/nvim-ts-context-commentstring") -- for tsx

optpack.add("Wansmer/treesj", {
  depends = { "nvim-treesitter" },
  load_on = { filetypes = { "go", "lua", "typescript", "typescriptreact" } },
  hooks = {
    post_load = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
      vim.keymap.set("n", "[exec]J", [[<Cmd>TSJSplit<CR>]])
    end,
  },
})

mypack.add("notomo/waitevent.nvim", {
  load_on = {
    modules = { "waitevent" },
    events = { "BufNew" },
  },
  hooks = {
    post_load = function()
      vim.env.GIT_EDITOR = require("waitevent").editor()

      vim.env.EDITOR = require("waitevent").editor({
        done_events = {},
        cancel_events = {},
      })
    end,
  },
})

mypack.add("notomo/runtimetable.nvim", {
  load_on = {
    modules = { "runtimetable" },
  },
  hooks = {
    post_add = require_fn("notomo.plugin.runtimetable"),
    post_install = function()
      require("notomo.plugin.runtimetable").save_all()
    end,
    post_update = function()
      require("notomo.plugin.runtimetable").save_all()
    end,
  },
})

mypack.add("notomo/unionbuf.nvim", {
  load_on = {
    modules = { "unionbuf" },
  },
})

mypack.add("notomo/pluginbuf.nvim", {
  load_on = {
    modules = { "pluginbuf" },
  },
})

mypack.add("notomo/obhook.nvim", {
  load_on = {
    modules = { "obhook" },
  },
})

mypack.add("notomo/lsp-handler-intercept.nvim", {
  load_on = {
    modules = { "lsp-handler-intercept" },
  },
})

optpack.add("uga-rosa/ccc.nvim", {
  load_on = { modules = { "ccc" }, cmds = { "Ccc*" } },
})

optpack.add("SmiteshP/nvim-navic", {
  depends = { "nvim-lspconfig" },
  load_on = { modules = { "nvim-navic" } },
})

optpack.add("windwp/nvim-ts-autotag", {
  depends = { "nvim-treesitter" },
  load_on = { filetypes = { "typescriptreact" } },
  hooks = {
    post_load = function()
      require("nvim-ts-autotag").setup({
        filetypes = { "typescriptreact" },
      })
    end,
  },
})
