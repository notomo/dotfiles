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

highlight Search cterm=NONE guifg=#333333 guibg=#a9dd9d
highlight incSearchOnCursor cterm=NONE guifg=#fffeeb guibg=#fb8965
highlight Flashy term=bold ctermbg=0 guifg=#333333 guibg=#a8d2eb
highlight ParenMatch term=underline cterm=underline guibg=#5f8770
highlight TabLine guifg=#fff5ee guibg=#536273 gui=none
highlight YankRoundRegion guifg=#333333 guibg=#fedf81
highlight def link sqlStatement sqlKeyword

syntax match myTodo contained '\<\(TODO\|FIXME\):'
highlight def link myTodo Todo
