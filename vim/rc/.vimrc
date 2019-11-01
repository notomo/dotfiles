
set encoding=utf-8
scriptencoding utf-8
let $LANG='ja_JP.UTF-8'

if (!has('nvim') || has('win32')) && has('vim_starting')
    set runtimepath^=~/.vim/
    set runtimepath+=~/.vim/after
    if has('kaoriya')
        let s:rtps = []
        for s:rpt in split(&runtimepath, ',')
            if s:rpt =~# 'vimfiles$'
                continue
            elseif s:rpt =~# 'vimfiles/after$'
                continue
            endif
            call add(s:rtps, s:rpt)
        endfor
        let &runtimepath = join(s:rtps, ',')
        set runtimepath+=$VIM/plugins/kaoriya
        source $VIM/plugins/kaoriya/encode_japan.vim
    endif
endif

filetype off
filetype plugin indent off

let g:mapleader = ','
let g:maplocalleader = '<Leader>l'
runtime! rc/minpac/minpac.vim

source ~/.vim/rc/plugins/gina.vim
source ~/.vim/rc/plugins/lightline.vim
if has('nvim')
    source ~/.vim/rc/plugins/vimonga.vim
    source ~/.vim/rc/plugins/kiview.vim
    source ~/.vim/rc/plugins/valtair.vim
    source ~/.vim/rc/plugins/lsp.vim
    if executable('node')
        source ~/.vim/rc/plugins/gesture.vim
        source ~/.vim/rc/plugins/ctrlb.vim
    endif
    if executable('python3.6') || executable('python3.7')
        source ~/.vim/rc/plugins/curstr.vim
        source ~/.vim/rc/plugins/denite.vim
        source ~/.vim/rc/plugins/deoplete.vim
        source ~/.vim/rc/plugins/defx.vim
    endif
endif
IncSearchNoreMap <Tab> <Over>(incsearch-next)
IncSearchNoreMap <S-Tab> <Over>(incsearch-prev)
IncSearchNoreMap <C-Space> <Tab>
IncSearchNoreMap <C-j> <Down>
IncSearchNoreMap <C-k> <Up>
IncSearchNoreMap <C-l> <Right>
IncSearchNoreMap <Space> <CR>
IncSearchNoreMap <C-n> <Over>(incsearch-scroll-f)
IncSearchNoreMap <C-p> <Over>(incsearch-scroll-b)

syntax enable
filetype plugin indent on

runtime! rc/local/*.vim
runtime! rc/base/*.vim
if has('nvim')
    runtime! rc/neovim/*.vim
endif

runtime! rc/local/after/*.vim
