let $LANG='ja_JP.UTF-8'
set encoding=utf-8

"ウィンドウを最大化して起動
au GUIEnter * simalt ~x
"日本語入力をリセット
au BufNewFile,BufRead * set iminsert=0
" 「日本語入力固定モード」の動作モード
let IM_CtrlMode = 4

let g:yankring_n_keys = 'Y D'
" default
" let g:yankring_n_keys = 'Y D x X'

set nowrap

set showtabline=2 " タブを常に表示
set guioptions-=e " gVimでもテキストベースのタブページを使う
" set incsearch  " インクリメンタルサーチを行う
set ignorecase
set smartcase
set hlsearch

if expand("%:t") !~ ".*\.tex"
    set autoindent
endif

set shellpipe=2>\&1\|nkf\ -uw>%s

set ruler
set number         " 行番号を表示する
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set cursorline     " カーソル行の背景色を変える
" set nolist
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set scrolloff=8                "上下8行の視界を確保
set showmatch      " 対応する括弧を強調表示
set wildmenu
set showcmd
set autoread   "外部でファイルに変更がされた場合は読みなおす
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
set shiftwidth=4
set softtabstop=4
set noexpandtab
set tabstop=4
set smarttab
set formatoptions=q
set clipboard=unnamed

" set autochdir
augroup vim_enter
  autocmd!
  autocmd BufEnter * execute ":lcd " . substitute(expand("%:p:h")," ","\\\\ ","g")
augroup END

" set grepprg=grep\ -rnih 
set grepprg=git\ grep\ -n\ $*
" set grepprg=jvgrep
" let $JVGREP_OUTPUT_ENCODING = 'sjis'

set wrapscan
" set nobackup
" バックアップファイル用のディレクトリ
set backupdir=~/.vim/tmp/backup/
" set noundofile
set undodir=~/.vim/tmp/undo/
"スワップファイル用のディレクトリ
set directory=~/.vim/tmp/swap/
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer 

set viminfo+=n~/.vim/tmp/viminfo.txt

let $PATH = $PATH . ';C:\MinGW64\bin;C:\MinGW64\msys\1.0\bin'
set statusline=%F%m%r%h%w\%=[COL=%c]\[FTYPE=%Y]\[ENC=%{&enc}]\[FENC=%{&fileencoding}]\[FORMAT=%{&ff}]

augroup new_file_utf8_unix
    autocmd!
    autocmd BufNewFile * set fileencoding=UTF-8
    autocmd BufNewFile * set fileformat=unix
augroup End

function! s:vimdiff_in_newtab(...)
  if a:0 == 1
    tabedit %:p
    exec 'rightbelow vertical diffsplit ' . a:1
  else
    exec 'tabedit ' . a:1
    for l:file in a:000[1 :]
      exec 'rightbelow vertical diffsplit ' . l:file
    endfor
  endif
endfunction
command! -bar -nargs=+ -complete=file Diff  call s:vimdiff_in_newtab(<f-args>)

if v:servername == 'GVIM1'
    let file = expand('%:p')
    bwipeout
    call remote_send('GVIM', '<ESC>:tabnew ' .file .'<CR>')
    call remote_foreground('GVIM')
    quit
endif
