let $LANG='ja_JP.UTF-8'
set encoding=utf-8

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/
    set runtimepath+=~/.vim/after/
    set runtimepath+=~/.vim/after/plugin/*
    set runtimepath+=~/.vim/after/syntax/*
endif

let g:mapleader = ","
let g:plugin_dicwin_disable = 1

source ~/.vim/userautoload/dein.vim

filetype plugin indent on
syntax on

augroup MyAuGroup
    autocmd!
augroup END

runtime! userautoload/local/*.vim
runtime! userautoload/init/*.vim
runtime! userautoload/plugins/dein/others.vim
runtime! userautoload/plugins/dein/fugitive_filetype_mapping.vim

