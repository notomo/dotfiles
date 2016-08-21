" let &termencoding = &encoding
let $LANG='ja_JP.UTF-8'
set encoding=utf-8

source ~/.vim/userautoload/neobundle.vim

filetype plugin indent on
filetype on
filetype plugin on
syntax on

augroup MyAuGroup
    autocmd!
augroup END

let g:mapleader = ","
let g:plugin_dicwin_disable = 1

runtime! userautoload/local/*.vim
runtime! userautoload/init/*.vim
runtime! userautoload/plugins/*.vim

set formatoptions-=r
set formatoptions-=o
