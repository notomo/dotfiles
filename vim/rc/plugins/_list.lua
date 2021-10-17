vim.cmd([[packadd optpack.nvim]])
local optpack = require("optpack")

local cmd = function(str)
  return function()
    vim.cmd(str)
  end
end

local source = function(path)
  return function()
    vim.cmd("source " .. path)
  end
end

local luafile = function(path)
  return function()
    vim.cmd("luafile " .. path)
  end
end

optpack.add("notomo/optpack.nvim", {
  fetch = {depth = 0},
  hooks = {
    post_add = function()
      vim.cmd([=[nnoremap [exec]U <Cmd>lua require("optpack").update()<CR>]=])
    end,
  },
})

optpack.add("notomo/vusted", {fetch = {depth = 0}})
optpack.add("notomo/virtes.nvim", {fetch = {depth = 0}})
optpack.add("notomo/genvdoc", {fetch = {depth = 0}, load_on = {modules = {"genvdoc"}}})

optpack.add("tbastos/vim-lua", {
  load_on = {filetypes = {"lua"}},
  hooks = {
    post_load = function()
      -- HACK
      local path
      for _, p in ipairs(vim.opt.runtimepath:get()) do
        if p:find("/vim%-lua$") then
          path = p
          break
        end
      end
      vim.opt.runtimepath:remove(path)
      vim.opt.runtimepath:prepend(path)
    end,
  },
})

optpack.add("kana/vim-textobj-user", {load_on = {events = {"VimEnter"}}})

optpack.add("kana/vim-submode", {
  load_on = {events = {"VimEnter"}},
  hooks = {
    post_add = function()
      vim.g.submode_keep_leaving_key = 1
      vim.g.submode_timeout = 0
    end,
  },
})

optpack.add("thinca/vim-zenspace", {
  load_on = {events = {"VimEnter"}},
  hooks = {
    post_add = function()
      vim.g["zenspace#default_mode"] = "on"
    end,
  },
})

optpack.add("LeafCage/yankround.vim", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/yankround.vim")},
})

optpack.add("kana/vim-smartword", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/smartword.vim")},
})

optpack.add("rhysd/vim-color-spring-night", {
  hooks = {
    post_add = function()
      vim.g.spring_night_kill_italic = 1
      vim.g.spring_night_high_contrast = 0
    end,
  },
})

optpack.add("lambdalisue/gina.vim", {load_on = {events = {"VimEnter"}}})

optpack.add("itchyny/lightline.vim", {
  load_on = {events = {"VimEnter"}},
  hooks = {
    post_load = function()
      vim.schedule(function()
        vim.cmd([[source ~/.vim/rc/plugins/lightline.vim]])
        vim.fn["lightline#update"]()
      end)
    end,
  },
})

optpack.add("kana/vim-textobj-entire", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/textobj-entire.vim")},
})

optpack.add("osyo-manga/vim-textobj-blockwise", {load_on = {events = {"VimEnter"}}})

optpack.add("kana/vim-textobj-line", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/textobj-line.vim")},
})

optpack.add("bkad/CamelCaseMotion", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/camelcasemotion.vim")},
})

optpack.add("osyo-manga/vim-textobj-from_regexp", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/.vim/rc/plugins/textobj-from_regexp.vim")},
})

optpack.add("haya14busa/vim-edgemotion", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/.vim/rc/plugins/edgemotion.vim")},
})

optpack.add("mhinz/vim-signify", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/.vim/rc/plugins/signify.vim")},
})

optpack.add("junegunn/vim-emoji", {load_on = {events = {"VimEnter"}}})

optpack.add("lambdalisue/suda.vim", {
  enabled = vim.fn.has("unix") == 1,
  load_on = {events = {"VimEnter"}},
  hooks = {
    post_add = cmd([[
let g:suda_startup = 1
nnoremap [file]W <Cmd>write suda://%<CR>
]]),
  },
})

optpack.add("w0rp/ale", {
  load_on = {events = {"FileType"}},
  hooks = {post_add = source("~/.vim/rc/plugins/ale.vim")},
})

optpack.add("voldikss/vim-translator", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/.vim/rc/plugins/translator.vim")},
})

optpack.add("notomo/wintablib.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"wintablib"}},
  hooks = {post_add = source("~/.vim/rc/plugins/wintablib.vim")},
})

optpack.add("notomo/lreload.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"lreload"}},
  hooks = {
    post_load = function()
      require("notomo.lreload")
    end,
  },
})

optpack.add("nanotee/luv-vimdocs", {load_on = {events = {"VimEnter"}}})

optpack.add("hrsh7th/nvim-cmp", {load_on = {modules = {"cmp"}, events = {"VimEnter"}}})
optpack.add("hrsh7th/cmp-nvim-lsp", {
  load_on = {modules = {"cmp", "cmp_nvim_lsp"}, events = {"VimEnter"}},
})
optpack.add("hrsh7th/cmp-buffer", {load_on = {modules = {"cmp"}, events = {"VimEnter"}}})
optpack.add("hrsh7th/cmp-path", {load_on = {modules = {"cmp"}, events = {"VimEnter"}}})
optpack.add("hrsh7th/cmp-nvim-lua", {load_on = {modules = {"cmp"}, events = {"VimEnter"}}})
optpack.add("notomo/cmp-neosnippet", {
  load_on = {modules = {"cmp"}, events = {"VimEnter"}},
  fetch = {depth = 0},
})

optpack.add("notomo/searcho.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"searcho"}},
  hooks = {post_add = source("~/.vim/rc/plugins/searcho.vim")},
})

optpack.add("AndrewRadev/linediff.vim", {
  load_on = {cmds = {"*Linediff"}},
  hooks = {post_add = cmd([[xnoremap [diff]l :Linediff<CR>]])},
})

optpack.add("tmhedberg/matchit", {load_on = {filetypes = {"html", "vim", "sql"}}})

optpack.add("thinca/vim-qfreplace", {load_on = {cmds = {"Qfreplace"}}})

optpack.add("tyru/open-browser.vim", {
  load_on = {cmds = {"OpenBrowser*"}},
  hooks = {post_add = source("~/.vim/rc/plugins/open-browser.vim")},
})

optpack.add("notomo/vimonga", {
  fetch = {depth = 0},
  load_on = {cmds = {"Vimonga*"}},
  hooks = {post_add = source("~/.vim/rc/plugins/vimonga.vim")},
})

optpack.add("notomo/curstr.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"curstr"}},
  hooks = {
    post_add = source("~/.vim/rc/plugins/curstr.vim"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/curstr.lua"),
  },
})

optpack.add("notomo/nvimtool", {load_on = {modules = {"nvimtool"}}, fetch = {depth = 0}})

optpack.add("notomo/piemenu.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"piemenu"}},
  hooks = {
    post_add = source("~/.vim/rc/plugins/piemenu.vim"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/piemenu.lua"),
  },
})

optpack.add("notomo/gesture.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"gesture"}},
  hooks = {
    post_add = source("~/.vim/rc/plugins/gesture.vim"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/gesture.lua"),
  },
})

optpack.add("notomo/flompt.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"flompt"}},
  hooks = {post_add = source("~/.vim/rc/plugins/flompt.vim")},
})

optpack.add("notomo/thetto.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"thetto"}},
  hooks = {
    post_add = source("~/.vim/rc/plugins/thetto.vim"),
    post_load = luafile("~/dotfiles/vim/lua/notomo/thetto.lua"),
  },
})

optpack.add("neovim/nvim-lspconfig", {load_on = {modules = {"lspconfig"}}})

optpack.add("notomo/kivi.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"kivi"}},
  hooks = {post_add = source("~/.vim/rc/plugins/kivi.vim")},
})

optpack.add("notomo/reacher.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"reacher"}},
  hooks = {post_add = source("~/.vim/rc/plugins/reacher.vim")},
})

optpack.add("dart-lang/dart-vim-plugin", {ft = "dart"})

optpack.add("notomo/cmdbuf.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"cmdbuf"}},
  hooks = {post_add = source("~/.vim/rc/plugins/cmdbuf.vim")},
})

optpack.add("notomo/filetypext.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"filetypext"}},
  hooks = {
    post_add = cmd([[
nnoremap [exec]; <Cmd>lua require("notomo.edit").scratch(require("filetypext").detect({bufnr = 0})[1], vim.bo.filetype ~= '' and vim.bo.filetype or "markdown")<CR>
]]),
  },
})

optpack.add("notomo/cmdhndlr.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"cmdhndlr"}},
  hooks = {post_add = source("~/.vim/rc/plugins/cmdhndlr.vim")},
})

optpack.add("notomo/suball.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"suball"}},
  hooks = {post_add = source("~/.vim/rc/plugins/suball.vim")},
})

optpack.add("nvim-treesitter/nvim-treesitter", {load_on = {cmds = {"TS*"}, modules = {"cmdhndlr"}}})
optpack.add("nvim-treesitter/nvim-treesitter-textobjects", {
  load_on = {cmds = {"TS*"}},
  hooks = {post_load = luafile("~/dotfiles/vim/lua/notomo/treesitter.lua")},
})

optpack.add("notomo/aliaser.nvim", {
  fetch = {depth = 0},
  load_on = {modules = {"aliaser"}},
  hooks = {post_load = luafile("~/dotfiles/vim/lua/notomo/aliaser.lua")},
})

optpack.add("tpope/vim-repeat", {load_on = {events = {"VimEnter"}}})

optpack.add("kana/vim-operator-user", {load_on = {events = {"VimEnter"}}})

optpack.add("osyo-manga/vim-textobj-multiblock", {
  load_on = {events = {"BufLeave"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/textobj-multiblock.vim")},
})

optpack.add("Shougo/neosnippet.vim", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/neosnippet.vim")},
})

optpack.add("osyo-manga/vim-operator-blockwise", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/operator-blockwise.vim")},
})

optpack.add("kana/vim-operator-replace", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/dotfiles/vim/rc/plugins/operator-replace.vim")},
})

optpack.add("rhysd/vim-operator-surround", {
  load_on = {events = {"VimEnter"}},
  hooks = {post_add = source("~/.vim/rc/plugins/operator-surround.vim")},
})

optpack.add("tyru/caw.vim", {
  load_on = {events = {"FileType"}},
  hooks = {post_add = source("~/.vim/rc/plugins/caw.vim")},
})
