local vim = vim
local o = vim.o
local option = require("notomo.lib.option")
local g = vim.g

if vim.fn.has("mac") ~= 1 then
  vim.cmd.language("en_US.UTF-8")
end

if vim.fn.has("wsl") == 1 then
  vim.env.PATH = vim
    .iter(vim.split(vim.env.PATH, ":", { plain = true }))
    :filter(function(x)
      return not vim.startswith(x, "/mnt/") or vim.endswith(x, "/use_from_wsl")
    end)
    :join(":")
end

g.no_plugin_maps = 1
g.plugin_dicwin_disable = 1
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_rrhelper = 1
g.loaded_2html_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_spellfile_plugin = 1
g.loaded_logiPat = 1
g.loaded_matchparen = 1
g.loaded_remote_plugins = 0
g.loaded_python3_provider = 0
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.python_highlight_all = 1
g.markdown_fenced_languages = { "vim" }
g.ft_ignore_pat = [[\.\(Z\|gz\|bz2\|zip\|tgz\|log\)$]]
if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
  vim.g.clipboard = "win32yank"
end

o.wrap = false
o.showtabline = 2
o.signcolumn = "yes"
o.ignorecase = true
o.smartcase = true
o.startofline = true
o.lazyredraw = true
o.ruler = false
o.number = true
o.whichwrap = "b,s,h,l,<,>,[,]"
o.cursorline = true
o.listchars = { tab = "»-", trail = "-", eol = "↲", extends = "»", precedes = "«", nbsp = "%" }
o.list = true
o.cmdheight = 1
o.scrolloff = 8
o.sidescrolloff = 24
o.showmatch = true
o.wildmode = "noselect:lastused,full"
option.append("wildoptions", "fuzzy")
o.switchbuf = "useopen"
option.append("matchpairs", "<:>")
o.shiftwidth = 0
o.softtabstop = 4
o.tabstop = 4
o.clipboard = "unnamed,unnamedplus"
o.showmode = false
option.append("nrformats", "unsigned")
option.append("shortmess", "I")
option.append("shortmess", "c")
option.remove("shortmess", "S")
option.append("diffopt", "vertical")
option.append("diffopt", "iwhite")
option.append("diffopt", "hiddenoff")
option.append("diffopt", "algorithm:histogram")
o.mouse = "a"
o.grepprg = [[git\ grep\ -n\ $*]]
o.swapfile = false
o.expandtab = true
o.foldenable = false
o.foldtext = ""
o.fillchars = "fold: "
vim.cmd([[set wildcharm=<C-z>]])
o.undofile = true
o.undoreload = 10
o.updatecount = 0
o.keywordprg = ":help"
option.remove("sessionoptions", "blank")
option.remove("sessionoptions", "buffers")
o.spelllang = "en,cjk"
o.shiftround = true
o.linebreak = true
o.copyindent = true
o.preserveindent = true
o.fixendofline = false
o.tagcase = "match"
o.completeopt = "menu,menuone,noselect,fuzzy,popup,nosort"
o.termguicolors = true
o.spelloptions = "camel"
o.cedit = [[<C-q>]]
o.cmdwinheight = 12
o.guicursor =
  [[n-v-c:block,i-ci-ve-t:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]
o.pumblend = 30
o.pumheight = 20
o.pumborder = "rounded"
o.shada = [['10,!,<50,/0,s10,h,@10,:100]]
if vim.fn.has("win32") ~= 1 then
  o.shell = "zsh"
end
o.shelltemp = false
o.laststatus = 3
o.mousescroll = "ver:2,hor:6"
o.mousemodel = "extend" -- to disable default popup
option.append("isfname", "@-@,[,],$")
o.tabclose = "left"

vim.filetype.add({
  filename = {
    ["supervisord.conf"] = "dosini",
    ["moon.pkg"] = "moonbitpkg",
  },
  extension = {
    flux = "flux",
    tf = "terraform",
    mdx = "mdx",
    mbt = "moonbit",
    gs = "javascript",
    sql = function(path)
      if path:find("/dbt/") then
        return "jinja"
      end
      return "sql"
    end,
  },
})

---@diagnostic disable-next-line: duplicate-set-field
vim.ui.input = function(...)
  return require("notomo.lib.input").open(...)
end
