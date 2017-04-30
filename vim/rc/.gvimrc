scriptencoding utf-8

set shortmess+=I
set visualbell t_vb=
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

colorscheme spring-night

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

