
scriptencoding utf-8
let $LANG='ja_JP.UTF-8'
set encoding=utf-8

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/
    set runtimepath+=~/.vim/dein/repos/*
    set runtimepath+=~/.vim/after/*
endif

let g:mapleader = ","

let g:plugin_dicwin_disable    = 1
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

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
set diffexpr=py3diff#diffexpr()
