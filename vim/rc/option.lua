local vim = vim
local opt = vim.opt
local g = vim.g

opt.encoding = "utf-8"
vim.env.LANG = "en_US.UTF-8"

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
g.loaded_python3_provider = 0
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.python_highlight_all = 1
g.markdown_fenced_languages = { "vim" }
g.do_filetype_lua = 1
g.did_load_filetypes = 0
g.ft_ignore_pat = [[\.\(Z\|gz\|bz2\|zip\|tgz\|log\)$]]
if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank",
    copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
    paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
    cache_enabled = 0,
  }
end

opt.wrap = false
opt.showtabline = 2
opt.signcolumn = "yes"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.spell = false
opt.startofline = true
opt.lazyredraw = true
opt.autoindent = true
opt.ruler = false
opt.number = true
opt.backspace = "indent,eol,start"
opt.whichwrap = "b,s,h,l,<,>,[,]"
opt.cursorline = true
opt.listchars = [[tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%]]
opt.list = true
opt.laststatus = 2
opt.cmdheight = 2
opt.scrolloff = 8
opt.sidescrolloff = 24
opt.showmatch = true
opt.wildmenu = true
opt.wildmode = "longest:full"
opt.showcmd = true
opt.autoread = true
opt.hidden = true
opt.switchbuf = "useopen"
opt.textwidth = 0
opt.matchpairs:append("<:>")
opt.shiftwidth = 0
opt.softtabstop = 4
opt.tabstop = 4
opt.smarttab = true
opt.clipboard = "unnamed,unnamedplus"
opt.foldmethod = "manual"
opt.showmode = false
opt.conceallevel = 0
opt.shortmess:append("I")
opt.shortmess:remove("S")
opt.visualbell = false
opt.diffopt:append("vertical")
opt.diffopt:append("iwhite")
opt.diffopt:append("hiddenoff")
opt.diffopt:append("algorithm:histogram")
opt.mouse = "a"
opt.grepprg = [[git\ grep\ -n\ $*]]
opt.wrapscan = true
opt.backupdir = vim.fn.expand("~/.vim/tmp/backup/")
opt.undofile = false
opt.swapfile = false
opt.title = false
opt.expandtab = true
opt.foldenable = true
opt.foldlevel = 3
vim.cmd([[set wildcharm=<C-z>]])
opt.undoreload = 0
opt.updatecount = 0
opt.keywordprg = ":help"
opt.helplang = "ja"
opt.sessionoptions:remove("blank")
opt.sessionoptions:remove("buffers")
opt.spelllang = "en,cjk"
opt.shiftround = true
opt.linebreak = true
opt.copyindent = true
opt.preserveindent = true
opt.fixendofline = false
opt.tagcase = "match"
opt.completeopt:remove("preview")
opt.termguicolors = true
opt.spelloptions = "camel"
opt.cedit = [[<C-q>]]
opt.cmdwinheight = 12
opt.inccommand = "nosplit"
opt.guicursor =
  [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]
opt.wildoptions:append("pum")
opt.pumblend = 15
opt.shada = [['10,!,<50,/0,s10,h,@10]]
if vim.fn.has("win32") ~= 1 then
  if vim.fn.has("vim_starting") == 1 then
    opt.runtimepath:prepend(vim.fn.expand("~/.vim/"))
    opt.runtimepath:append(vim.fn.expand("~/.vim/after"))
  end
  opt.shell = "zsh"
end
