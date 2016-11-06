
set shortmess+=I
set guioptions+=b
set guioptions+=a
set vb t_vb=
set guioptions-=T
set guioptions-=m
set background=dark
colorscheme desert

if has("mac")
    set guifont=RictyDiminished-Regular:h18
elseif has("win64") || has("win32")
    set guifont=MeiryoKe_Gothic:h14:cSHIFTJIS
endif

hi TabLineFill guifg=#000000 guibg=#ffffff
hi TabLine guifg=#aaaaaa guibg=#000000 gui=NONE
hi TabLineSel guifg=#bbbb88 guibg=#333333 gui=underline
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel ctermfg=15 ctermbg=0 guifg=#000000 guibg=#cccccc
hi TabLineInfo term=reverse ctermfg=Black ctermbg=LightBlue guifg=black guibg=lightblue

hi Search cterm=NONE guifg=#333333 guibg=#9acd32
hi incSearchOnCursor cterm=NONE guifg=#eeeeee guibg=#ff7f50

hi phpComment guifg=#afeeee
hi Comment guifg=#afeeee
