scriptencoding utf-8

let g:plugin_dicwin_disable = 1
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_matchparen = 1

augroup MyAuGroup
    autocmd!
augroup END

autocmd MyAuGroup BufNewFile,BufRead * set iminsert=0

autocmd MyAuGroup BufEnter * call s:auto_cd()
function! s:auto_cd() abort
    try
        lcd `=expand('%:p:h')`
    catch
    endtry
endfunction

autocmd MyAuGroup VimEnter * if @% == '' && s:get_buf_byte() == 0 | setlocal buftype=nofile noswapfile fileformat=unix | endif
function! s:get_buf_byte()
    let byte = line2byte(line('$') + 1)
    return byte == -1 ? 0 : byte - 1
endfunction

function! s:define_highlight() abort
    highlight Search cterm=NONE guifg=#000000 guibg=#aaccaa
    highlight incSearch cterm=NONE guifg=#fffeeb guibg=#fb8965
    highlight Flashy term=bold ctermbg=0 guifg=#333333 guibg=#a8d2eb
    highlight ParenMatch term=underline cterm=underline guibg=#5f8770
    highlight TabLine guifg=#fff5ee guibg=#536273 gui=none
    highlight YankRoundRegion guifg=#333333 guibg=#fedf81
    highlight def link sqlStatement sqlKeyword
    highlight ZenSpace term=underline ctermbg=DarkGreen guibg=#ab6560
    highlight NormalFloat guibg=#213243

    " for gina status
    highlight AnsiColor1 ctermfg=1 guifg=#ffaaaa
    highlight AnsiColor2 ctermfg=2 guifg=#aaddaa

    highlight clear SpellCap
    highlight def link SpellCap NONE
    highlight clear SpellBad
    highlight SpellBad guifg=#ff5555
    highlight clear SpellRare
    highlight SpellRare guifg=#ff5555
    highlight clear SpellLocal
    highlight SpellLocal guifg=#ff5555

    if has('mac')
        highlight Cursor guibg=#bbbbba
    endif
endfunction

autocmd MyAuGroup ColorScheme * :call s:define_highlight()

autocmd MyAuGroup InsertEnter * :setlocal nocursorline
autocmd MyAuGroup InsertLeave * :setlocal cursorline
autocmd MyAuGroup WinEnter * :setlocal cursorline
autocmd MyAuGroup WinLeave * :setlocal nocursorline

autocmd MyAuGroup BufRead,BufNewFile */roles/*.yml set filetype=yaml.ansible
autocmd MyAuGroup BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible

autocmd MyAuGroup FileType typescriptreact set filetype=typescript.tsx

set guioptions+=M
set guioptions+=c

let g:loaded_python3_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

let g:python_highlight_all = 1
let g:markdown_fenced_languages = ['vim']
let g:ft_ignroe_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\|log\)$'

autocmd MyAuGroup OptionSet diff setlocal nocursorline
autocmd MyAuGroup WinEnter,InsertLeave * if &diff == 1 | setlocal nocursorline | endif

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
