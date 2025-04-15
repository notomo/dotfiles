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
        group = vim.api.nvim_create_augroup("notomo.optpack.mapping", {}),
        pattern = { "optpack" },
        callback = function()
          vim.keymap.set("n", "<CR>", function()
            local update = vim.b.optpack_updates[tostring(vim.fn.line("."))]
            if not update then
              return
            end
            require("thetto.util.source").start_by_name("git/log", {
              cwd = update.directory,
              opts = { args = { update.revision_range } },
            })
          end, { buffer = true })
        end,
      })
      vim.keymap.set("n", "[exec]U", function()
        local tabpage
        require("optpack").update({
          outputters = {
            buffer = {
              open = function(bufnr)
                vim.cmd.tabedit()
                tabpage = vim.api.nvim_get_current_tabpage()

                vim.bo.buftype = "nofile"
                vim.bo.bufhidden = "wipe"
                vim.cmd.buffer(bufnr)
              end,
            },
          },
          on_finished = function()
            local tmp_tabpage = vim.api.nvim_get_current_tabpage()
            vim.api.nvim_set_current_tabpage(tabpage)

            local close_on_success = {
              success = function(info)
                local window_id = info.window_id
                if not vim.api.nvim_win_is_valid(window_id) then
                  return
                end
                vim.api.nvim_win_close(window_id, true)
              end,
            }

            require("cmdhndlr").test({
              name = "make/make",
              layout = { type = "horizontal" },
              working_dir_marker = function()
                return vim.fn.expand("~/dotfiles/vim/Makefile")
              end,
              hooks = close_on_success,
            })
            require("cmdhndlr").run({
              name = "make/make",
              layout = { type = "horizontal" },
              runner_opts = {
                target = "help_tags",
              },
              working_dir_marker = function()
                return vim.fn.expand("~/dotfiles/vim/Makefile")
              end,
              hooks = close_on_success,
            })

            vim.api.nvim_set_current_tabpage(tmp_tabpage)
          end,
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

optpack.add("bkad/CamelCaseMotion", {
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "n", "x", "o" }, "<Leader>w", "<Plug>CamelCaseMotion_w")
      vim.keymap.set({ "n", "x", "o" }, "<Leader>b", "<Plug>CamelCaseMotion_b")
      vim.keymap.set({ "n", "x", "o" }, "<Leader>e", "<Plug>CamelCaseMotion_e")
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

local enabled_copilot = vim.g.notomo_enabled_copilot == true
local plenary_nvim = optpack.add("nvim-lua/plenary.nvim")
optpack.add("CopilotC-Nvim/CopilotChat.nvim", {
  enabled = enabled_copilot,
  depends = { plenary_nvim.name },
  load_on = {
    cmds = { "CopilotChat*" },
    modules = { "CopilotChat" },
    keymaps = function(vim)
      vim.keymap.set({ "n", "x" }, "gl", function()
        require("aliaser").call("copilot/chat")
      end)
    end,
  },
  hooks = {
    post_load = function()
      require("CopilotChat").setup({
        highlight_selection = false,
        highlight_headers = false,
        insert_at_end = false,
        mappings = {
          complete = {
            insert = "",
          },
          close = {
            normal = "",
            insert = "",
          },
          reset = {
            normal = "",
            insert = "",
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "",
          },
          toggle_sticky = {
            normal = "",
          },
          accept_diff = {
            normal = "",
            insert = "",
          },
          jump_to_diff = {
            normal = "",
          },
          quickfix_diffs = {
            normal = "",
          },
          yank_diff = {
            normal = "",
          },
          show_diff = {
            normal = "",
          },
          show_info = {
            normal = "",
          },
          show_context = {
            normal = "",
          },
          show_help = {
            normal = "",
          },
        },
      })
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
        return [[/\V]] .. vim.fn.escape(vim.fn.getreg([["]]), [[/\]])
      end, { expr = true })
      vim.keymap.set({ "n", "x" }, "s<Space>k", function()
        return [[?\V]] .. vim.fn.escape(vim.fn.getreg([["]]), [[/\]])
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
  load_on = { filetypes = { "html", "vim", "sql", "astro" } },
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

local nvim_lspconfig = optpack.add("neovim/nvim-lspconfig", {
  load_on = { events = { "FileType" } },
  hooks = {
    post_load = function()
      require("notomo.lsp.handler")
      require("notomo.plugin.nvim-lspconfig")
      vim.cmd.edit({ mods = { silent = true, emsg_silent = true } }) -- restart
    end,
  },
})

optpack.add("yioneko/nvim-vtsls", {
  load_on = {
    modules = { "vtsls" },
    filetypes = { "typescript", "typescriptreact" },
  },
  hooks = {
    post_load = require_fn("notomo.plugin.nvim-vtsls"),
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
  hooks = {
    post_add = require_fn("notomo.plugin.cmdhndlr"),
    post_load = function()
      local hooks = {
        post_execute = function(ctx)
          require("notomo.lib.edit").set_title(ctx.bufnr, ctx.cmd)
        end,
      }
      require("cmdhndlr").setup({
        opts = {
          normal_runner = { ["_"] = { hooks = hooks } },
          test_runner = { ["_"] = { hooks = hooks } },
          build_runner = { ["_"] = { hooks = hooks } },
        },
      })
    end,
  },
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

local nvim_treesitter = optpack.add("nvim-treesitter/nvim-treesitter", {
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
  depends = { nvim_treesitter.name },
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

local vim_operator_user = optpack.add("kana/vim-operator-user")

optpack.add("Shougo/neosnippet.vim", {
  load_on = { events = { "InsertEnter" } },
  hooks = {
    pre_load = require_fn("notomo.plugin.neosnippet"),
    post_load = function()
      vim.cmd.runtime([[ftdetect/neosnippet.vim]])
    end,
  },
})

optpack.add("kana/vim-operator-replace", {
  depends = { vim_operator_user.name },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "n", "x", "o" }, "r", [[<Plug>(operator-replace)]])
      vim.keymap.set("o", "<Plug>(builtin-gn)", [[gn]])
      vim.keymap.set("n", "<Plug>(builtin-/)", [[/]])
      vim.keymap.set("n", "<Plug>(builtin-N)", [[N]])
      vim.keymap.set("c", "<Plug>(builtin-CR)", [[<CR>]])
      vim.keymap.set("n", "[edit]n", [[*<Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)]], { remap = true })

      ---@diagnostic disable-next-line: duplicate-set-field
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
  depends = { vim_operator_user.name },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set({ "n", "x" }, "[surround]", "<Nop>")
      vim.keymap.set({ "n", "x" }, "s", "[surround]", { remap = true })

      vim.keymap.set({ "n", "x" }, "[surround]a", [[<Plug>(operator-surround-append)]], { silent = true })
      vim.keymap.set("n", "[surround]d", [[vaj<Plug>(operator-surround-delete)]], { silent = true, remap = true })
      vim.keymap.set("x", "[surround]d", [[<Plug>(operator-surround-delete)]], { silent = true })
      vim.keymap.set("n", "[surround]r", [[vaj<Plug>(operator-surround-replace)]], { silent = true, remap = true })
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
  depends = { nvim_treesitter.name },
  load_on = { modules = { "gettest" } },
})

mypack.add("notomo/tracebundler.nvim", {
  load_on = { modules = { "tracebundler" } },
})

local nvim_dap = optpack.add("mfussenegger/nvim-dap", {
  load_on = {
    modules = { "dap" },
    filetypes = { "go", "lua" },
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
  depends = { nvim_dap.name },
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
  depends = { nvim_treesitter.name },
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
        vim.o.cmdheight = 1 -- workaround
        require("thetto.util.source").start_by_name("hlmsg", {
          consumer_opts = {
            ui = {
              insert = false,
              display_limit = 10000,
            },
          },
        }, {
          item_cursor_factory = require("thetto.util.item_cursor").bottom(),
        })
      end)
    end,
  },
})

mypack.add("notomo/assertlib.nvim", {
  load_on = { modules = { "assertlib" } },
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

optpack.add("folke/ts-comments.nvim", {
  load_on = {
    keymaps = function(vim)
      vim.keymap.set("n", "<Space>c", "gcc", { remap = true })
      vim.keymap.set("x", "<Space>c", "gc", { remap = true })
    end,
  },
  hooks = {
    post_load = function()
      require("ts-comments").setup()
    end,
  },
})

optpack.add("Wansmer/treesj", {
  depends = { nvim_treesitter.name },
  load_on = {
    keymaps = function(vim)
      vim.keymap.set("n", "[exec]J", [[<Cmd>TSJSplit<CR>]])
      vim.keymap.set("n", "[exec]K", [[<Cmd>TSJJoin<CR>]])
    end,
  },
  hooks = {
    post_load = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
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
      local editor = require("waitevent").editor()
      vim.env.GIT_EDITOR = editor
      vim.env.REACT_EDITOR = editor

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

mypack.add("notomo/requireall.nvim", {
  load_on = {
    modules = { "requireall" },
  },
})

mypack.add("notomo/redraw-inspect.nvim", {
  load_on = {
    modules = { "redraw-inspect" },
  },
})

mypack.add("notomo/multito.nvim", {
  load_on = {
    modules = { "multito" },
    events = { "FileType" },
  },
  hooks = {
    post_load = require_fn("notomo.plugin.multito"),
  },
})

optpack.add("uga-rosa/ccc.nvim", {
  load_on = { modules = { "ccc" }, cmds = { "Ccc*" } },
})

optpack.add("SmiteshP/nvim-navic", {
  depends = { nvim_lspconfig.name },
  load_on = { modules = { "nvim-navic" } },
})

optpack.add("stevearc/aerial.nvim", {
  depends = { nvim_treesitter.name },
  load_on = { modules = { "aerial" } },
})
