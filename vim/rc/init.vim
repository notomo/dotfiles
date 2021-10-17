set encoding=utf-8
scriptencoding utf-8
let $LANG = 'en_US.UTF-8'

if has('win32') && has('vim_starting')
    set runtimepath^=~/.vim/
    set runtimepath+=~/.vim/after
endif

filetype off
filetype plugin indent off

runtime! rc/local/*.vim rc/local/*.lua
source ~/.vim/rc/option.vim
source ~/.vim/rc/mapping.vim

try
    luafile ~/.vim/rc/plugins/_manager.lua
catch
    " avoid aborting
    echohl ErrorMsg
    echomsg v:exception
    echohl None
endtry

syntax enable
filetype plugin indent on
colorscheme spring-night

runtime! rc/local/after/*.vim rc/local/after/*.lua
