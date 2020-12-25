set shortmess+=I
set visualbell t_vb=
set guioptions+=b
set guioptions-=a
set guioptions-=T
set guioptions-=m
set background=dark

set mouse=a
set nomousefocus
set mousehide

colorscheme spring-night

if has('win32')
    set guifont=MeiryoKe_Gothic:h14:cSHIFTJIS
    set linespace=1
elseif has('mac')
    set guifont=RictyDiminished-Regular:h18
endif
