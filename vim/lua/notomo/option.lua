local vim = vim
local opt = vim.opt
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

opt.wrap = false
opt.showtabline = 2
opt.signcolumn = "yes"
opt.ignorecase = true
opt.smartcase = true
opt.startofline = true
opt.lazyredraw = true
opt.ruler = false
opt.number = true
opt.whichwrap = "b,s,h,l,<,>,[,]"
opt.cursorline = true
opt.listchars = { tab = "»-", trail = "-", eol = "↲", extends = "»", precedes = "«", nbsp = "%" }
opt.list = true
opt.cmdheight = 1
opt.scrolloff = 8
opt.sidescrolloff = 24
opt.showmatch = true
opt.wildmode = "noselect:lastused,full"
opt.wildoptions:append("fuzzy")
opt.switchbuf = "useopen"
opt.matchpairs:append("<:>")
opt.shiftwidth = 0
opt.softtabstop = 4
opt.tabstop = 4
opt.clipboard = "unnamed,unnamedplus"
opt.showmode = false
opt.nrformats:append("unsigned")
opt.shortmess:append("I")
opt.shortmess:append("c")
opt.shortmess:remove("S")
opt.diffopt:append("vertical")
opt.diffopt:append("iwhite")
opt.diffopt:append("hiddenoff")
opt.diffopt:append("algorithm:histogram")
opt.mouse = "a"
opt.grepprg = [[git\ grep\ -n\ $*]]
opt.swapfile = false
opt.expandtab = true
opt.foldenable = false
opt.foldtext = ""
opt.fillchars = "fold: "
vim.cmd([[set wildcharm=<C-z>]])
opt.undofile = true
opt.undoreload = 10
opt.updatecount = 0
opt.keywordprg = ":help"
opt.sessionoptions:remove("blank")
opt.sessionoptions:remove("buffers")
opt.spelllang = "en,cjk"
opt.shiftround = true
opt.linebreak = true
opt.copyindent = true
opt.preserveindent = true
opt.fixendofline = false
opt.tagcase = "match"
opt.completeopt = "menu,menuone,noselect,fuzzy,popup,nosort"
opt.termguicolors = true
opt.spelloptions = "camel"
opt.cedit = [[<C-q>]]
opt.cmdwinheight = 12
opt.guicursor =
  [[n-v-c:block,i-ci-ve-t:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]
opt.pumblend = 30
opt.pumheight = 20
opt.shada = [['10,!,<50,/0,s10,h,@10,:100]]
if vim.fn.has("win32") ~= 1 then
  opt.shell = "zsh"
end
opt.shelltemp = false
opt.laststatus = 3
opt.mousescroll = "ver:2,hor:6"
opt.mousemodel = "extend" -- to disable default popup
opt.isfname:append("@-@,[,],$")
opt.tabclose = "left"

vim.filetype.add({
  filename = {
    ["supervisord.conf"] = "dosini",
  },
  extension = {
    flux = "flux",
    tf = "terraform",
  },
})
