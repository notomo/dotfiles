scriptencoding utf-8

set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set nowrap
set showtabline=2
set guioptions-=e
set guioptions+=c
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
set nocursorline
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set list
set laststatus=2
set cmdheight=2
set scrolloff=8
set showmatch
set wildmenu
set wildmode=longest:full
set showcmd
set autoread
set hidden
set switchbuf=useopen
set textwidth=0
set matchpairs+=<:>
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab
set clipboard=unnamed
set foldmethod=manual
set noshowmode
set conceallevel=0
set shortmess+=I
set visualbell t_vb=
set diffopt+=vertical
set mouse=a
set grepprg=git\ grep\ -n\ $*
set wrapscan
set backupdir=~/.vim/tmp/backup/
set noundofile
set noswapfile
set browsedir=buffer
set notitle
set nofixendofline
set statusline=[%c]\%=%F%m%r%h%w\ \[%{&fileencoding}:%{&ff}:%Y]
set expandtab
set nofoldenable
set foldlevel=3
set wildcharm=<C-z>
set undoreload=0
set updatecount=0
set tagcase=match
if !has('nvim')
    set viminfo+=n~/.vim/tmp/viminfo.txt
    set swapsync=
endif

if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  set iskeyword=@,48-57,_,128-167,224-235
endif

if !has('gui')
    colorscheme spring-night
endif

" tabline"{{{
set tabline=%!MakeTabLine()

function! MakeTabLine() "{{{
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  return join(titles, '') . '%#TabLineFill#%T'
endfunction "}}}

function! s:tabpage_label(tab_num) "{{{
    let tab_bufs = tabpagebuflist(a:tab_num)
    let curbuf_num = tab_bufs[tabpagewinnr(a:tab_num) - 1]
    let buf_cnt = len(tab_bufs)

    let file_nm = fnamemodify(bufname(curbuf_num), ':t')
    if file_nm ==# '[Command Line]'
        let file_nm = expand('#')
        let buf_cnt -= 1
    endif
    let file_nm = file_nm ==? '' ? 'NONE' : file_nm

    if getbufvar(curbuf_num, '&modified')
        let is_mod_str = '+'
    elseif buf_cnt == 1
        let is_mod_str = ''
        let buf_cnt = ''
    else
        let is_mod_tab = len(filter(copy(tab_bufs), "getbufvar(v:val, '&modified')"))
        let is_mod_str = is_mod_tab ? '(+)' : ''
    endif

    let option_str = buf_cnt . is_mod_str
    let label = option_str ==? '' ? file_nm : file_nm . '[' . option_str . ']'

    let hi_type = a:tab_num == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

    return '%' . a:tab_num . 'T' . join([hi_type, label, '%T%#TabLineFill#'], ' ')
endfunction "}}}
"}}}
