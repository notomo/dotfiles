
set encoding=utf-8
scriptencoding utf-8

if (!has('nvim') || has('win32')) && has('vim_starting')
    set runtimepath^=~/.vim/
    set runtimepath+=~/.vim/after
    if has('kaoriya')
        let s:rtps = []
        for s:rtp in split(&runtimepath, ',')
            if s:rtp =~# 'vimfiles$'
                continue
            elseif s:rtp =~# 'vimfiles/after$'
                continue
            endif
            call add(s:rtps, s:rtp)
        endfor
        let &runtimepath = join(s:rtps, ',')
        set runtimepath+=$VIM/plugins/kaoriya
        source $VIM/plugins/kaoriya/encode_japan.vim
    endif
endif

filetype off
filetype plugin indent off

try
    runtime! rc/minpac/minpac.vim
catch
    " avoid aborting
    echohl ErrorMsg
    echomsg v:exception
    echohl None
endtry

syntax enable
filetype plugin indent on

runtime! rc/local/*.vim
runtime! rc/base/*.vim
if has('nvim')
    runtime! rc/neovim/*.vim
endif

runtime! rc/local/after/*.vim
