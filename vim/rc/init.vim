set encoding=utf-8
scriptencoding utf-8
let $LANG = 'en_US.UTF-8'

filetype off
filetype plugin indent off

runtime! rc/local/*.vim
source ~/.vim/rc/option.vim
source ~/.vim/rc/mapping.vim

try
    source ~/.vim/rc/plugins/minpac.vim
catch
    " avoid aborting
    echohl ErrorMsg
    echomsg v:exception
    echohl None
endtry

syntax enable
filetype plugin indent on
colorscheme spring-night

runtime! rc/local/after/*.vim
