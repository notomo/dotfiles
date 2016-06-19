
let $LANG='ja_JP.UTF-8'
set encoding=utf-8
source ~/.vim/userautoload/neobundle.vim

filetype plugin indent on
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
syntax on

augroup MyAuGroup
    autocmd!
augroup END

runtime! userautoload/init/*.vim
runtime! userautoload/plugins/*.vim

if exists('g:home_vim')
	set expandtab
endif

set formatoptions-=r
set formatoptions-=o
