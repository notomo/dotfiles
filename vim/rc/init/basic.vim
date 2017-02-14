scriptencoding utf-8

if has('gui') && has('win64')
    "ウィンドウを最大化して起動
    autocmd MyAuGroup GUIEnter * simalt ~x
endif
"日本語入力をリセット
autocmd MyAuGroup BufNewFile,BufRead * set iminsert=0
" 「日本語入力固定モード」の動作モード
let g:IM_CtrlMode = 4

set nowrap
set showtabline=2 " タブを常に表示
set guioptions-=e " gVimでもテキストベースのタブページを使う
set ignorecase
set smartcase
set hlsearch
set nospell
set nostartofline
set lazyredraw
set autoindent
set noruler
set number         " 行番号を表示する
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set nocursorline
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set list
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set scrolloff=8                "上下8行の視界を確保
set showmatch      " 対応する括弧を強調表示
set wildmenu
set wildmode=longest:full
set showcmd
set autoread   "外部でファイルに変更がされた場合は読みなおす
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set textwidth=0 " 勝手に改行しないようにする
set matchpairs& matchpairs+=<:> " 対応括弧に'<'と'>'のペアを追加
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab
set formatoptions+=q
set clipboard=unnamed
set foldmethod=manual
set noshowmode

autocmd MyAuGroup BufEnter * call s:auto_cd()
function! s:auto_cd() abort
    try
        execute ':lcd ' . substitute(expand('%:p:h'),' ','\\\\ ','g')
    catch
    endtry
endfunction

autocmd MyAuGroup VimEnter * if @% == '' && s:get_buf_byte() == 0 | setlocal buftype=nofile noswapfile | endif
function! s:get_buf_byte()
    let byte = line2byte(line('$') + 1)
    if byte == -1
        return 0
    else
        return byte - 1
    endif
endfunction

autocmd MyAuGroup FileType * setlocal completeopt-=preview

set grepprg=git\ grep\ -n\ $*
set wrapscan
set backupdir=~/.vim/tmp/backup/
set noundofile
set noswapfile
set browsedir=buffer "ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set viminfo+=n~/.vim/tmp/viminfo.txt
set notitle
set nofixendofline

let g:file_format_map = {'unix' : 'U', 'dos' : 'D', 'mac' : 'M'}
set statusline=[%c]\%=%F%m%r%h%w\ \[%{&fileencoding}:%{file_format_map[&ff]}:%Y]

autocmd MyAuGroup BufNewFile * set fileencoding=UTF-8 fileformat=unix

autocmd MyAuGroup FileType * setlocal fo=cql
autocmd MyAuGroup FileType text setlocal textwidth=0

command! -nargs=0 CdCurrent cd %:p:h

command! -bar TimerStart let start_time = reltime()
command! -bar TimerEnd   echo reltimestr(reltime(start_time)) | unlet start_time

if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  set iskeyword=@,48-57,_,128-167,224-235
endif
