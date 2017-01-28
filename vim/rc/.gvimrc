scriptencoding utf-8

set shortmess+=I
set vb t_vb=
set guioptions+=b
set guioptions-=a
set guioptions-=T
set guioptions-=m
set background=dark

" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide

colorscheme desert

if has('win32')
    set guifont=MeiryoKe_Gothic:h14:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
    set guifont=RictyDiminished-Regular:h18
endif

highlight TabLineFill guifg=#000000 guibg=#ffffff
highlight TabLine guifg=#aaaaaa guibg=#000000 gui=NONE
highlight TabLineSel guifg=#bbbb88 guibg=#333333 gui=underline
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel ctermfg=15 ctermbg=0 guifg=#000000 guibg=#cccccc
highlight TabLineInfo term=reverse ctermfg=Black ctermbg=LightBlue guifg=black guibg=lightblue

highlight Search cterm=NONE guifg=#333333 guibg=#9acd32
highlight incSearchOnCursor cterm=NONE guifg=#eeeeee guibg=#ff7f50

highlight phpComment guifg=#afeeee
highlight Comment guifg=#afeeee

highlight Flashy term=bold ctermbg=0 gui=reverse guifg=#ffbf50 guibg=#222222

highlight ParenMatch term=underline cterm=underline guibg=cadetblue

syntax match myTodo contained '\<\(TODO\|FIXME\):'
highlight def link myTodo Todo
