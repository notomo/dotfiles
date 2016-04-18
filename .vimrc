
source ~/.vim/userautoload/neobundle.vim

filetype plugin indent on
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
syntax on

runtime! userautoload/init/*.vim
runtime! userautoload/plugins/*.vim
