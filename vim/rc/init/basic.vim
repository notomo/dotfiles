scriptencoding utf-8

set nowrap
set showtabline=2
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
set matchpairs& matchpairs+=<:>
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
set viminfo+=n~/.vim/tmp/viminfo.txt
set notitle
set nofixendofline
set statusline=[%c]\%=%F%m%r%h%w\ \[%{&fileencoding}:%{&ff}:%Y]
set expandtab
set nofoldenable
set foldlevel=3

if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  set iskeyword=@,48-57,_,128-167,224-235
endif

if !has('gui')
    colorscheme spring-night
endif

autocmd MyAuGroup BufNewFile,BufRead * set iminsert=0
autocmd MyAuGroup BufNewFile * set fileencoding=UTF-8 fileformat=unix
autocmd MyAuGroup FileType help wincmd L

if has('gui') && has('win32')
    autocmd MyAuGroup GUIEnter * simalt ~x
endif

autocmd MyAuGroup BufEnter * call s:auto_cd()
function! s:auto_cd() abort
    try
        execute ':lcd ' . substitute(expand('%:p:h'),' ','\\\\ ','g')
    catch
    endtry
endfunction

autocmd MyAuGroup VimEnter * if @% == '' && s:get_buf_byte() == 0 | setlocal buftype=nofile noswapfile fileformat=unix | endif
function! s:get_buf_byte()
    let byte = line2byte(line('$') + 1)
    return byte == -1 ? 0 : byte - 1
endfunction

command! -nargs=0 CdCurrent cd %:p:h
command! -bar TimerStart let start_time = reltime()
command! -bar TimerEnd   echo reltimestr(reltime(start_time)) | unlet start_time

