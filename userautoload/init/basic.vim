

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

if expand("%:t") !~ ".*\.tex"
    set autoindent
endif

set ruler
set number         " 行番号を表示する
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set cursorline     " カーソル行の背景色を変える
set nolist
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
set expandtab
set tabstop=4
set smarttab
set formatoptions=q
set clipboard=unnamed
" set autochdir
set grepprg=grep\ -rnIH 

set wrapscan
set nobackup
set noundofile
"スワップファイル用のディレクトリ
set directory=$HOME/vimbackup
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer 

let $PATH = $PATH . ';C:\MinGW64\bin;C:\MinGW64\msys\1.0\bin'
set statusline=%F%m%r%h%w\%=[COL=%c]\[FTYPE=%Y]\[ENC=%{&enc}]\[FENC=%{&fileencoding}]\[FORMAT=%{&ff}]
