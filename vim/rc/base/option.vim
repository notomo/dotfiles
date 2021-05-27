scriptencoding utf-8

set nowrap
set showtabline=2
set signcolumn=yes
set guioptions-=e
set ignorecase
set smartcase
set hlsearch
set nospell
set nostartofline
set lazyredraw
set autoindent
set noruler
set number
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set cursorline
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set list
set laststatus=2
set cmdheight=2
set scrolloff=8
set sidescrolloff=24
set showmatch
set wildmenu
set wildmode=longest:full
set showcmd
set autoread
set hidden
set switchbuf=useopen
set textwidth=0
set matchpairs+=<:>
set shiftwidth=0
set softtabstop=4
set tabstop=4
set smarttab
set clipboard=unnamed
set foldmethod=manual
set noshowmode
set conceallevel=0
set shortmess+=I
set shortmess-=S
set visualbell t_vb=
set diffopt+=vertical
set diffopt+=iwhite
set diffopt+=hiddenoff
set diffopt+=algorithm:histogram
set mouse=a
set grepprg=git\ grep\ -n\ $*
set wrapscan
set backupdir=~/.vim/tmp/backup/
set noundofile
set noswapfile
set browsedir=buffer
set notitle
set expandtab
set nofoldenable
set foldlevel=3
set wildcharm=<C-z>
set undoreload=0
set updatecount=0
set keywordprg=:help
set helplang=ja
set sessionoptions-=blank
set sessionoptions-=buffers
set spelllang=en,cjk
set shiftround
set linebreak
set copyindent
set preserveindent
set nofixendofline
set tagcase=match
set completeopt-=preview
set termguicolors
set spelloptions=camel
set cedit=<C-q>
set cmdwinheight=12

if executable('zsh')
    set shell=zsh
endif

if !has('gui')
    colorscheme spring-night
endif

set clipboard+=unnamedplus
if has('win32')
    let g:clipboard = {
        \ 'name': 'win32yank',
        \ 'copy': {'+': 'win32yank -i --crlf', '*': 'win32yank -i --crlf'},
        \ 'paste': {'+': 'win32yank -o --lf', '*': 'win32yank -o --lf'},
        \ 'cache_enabled': 0,
    \ }
endif

set inccommand=nosplit
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
set wildoptions+=pum
set pumblend=15
set shada^='1000

autocmd MyAuGroup TextYankPost * silent! lua vim.highlight.on_yank({higroup = "Flashy", timeout = 200, on_macro = true, on_visual = true})
