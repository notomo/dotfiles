set encoding=utf-8
scriptencoding utf-8
let $LANG = 'en_US.UTF-8'

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
runtime! rc/local/after/*.vim
