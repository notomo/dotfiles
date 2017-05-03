
set encoding=utf-8
scriptencoding utf-8
let $LANG='ja_JP.UTF-8'

if has('vim_starting')
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
runtime! rc/dein/dein.vim

syntax enable
filetype plugin indent on

if !has('vim_starting')
    call dein#call_hook('source')
    call dein#call_hook('post_source')
endif

runtime! rc/local/*.vim
runtime! rc/base/*.vim
if has('nvim')
    runtime! rc/neovim/*.vim
endif

runtime! rc/local/after/*.vim

