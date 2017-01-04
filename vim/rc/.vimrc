
scriptencoding utf-8
let $LANG='ja_JP.UTF-8'
set encoding=utf-8

if has('vim_starting')
    set runtimepath+=~/.vim/
    set runtimepath+=~/.vim/dein/repos/*
    set runtimepath+=~/.vim/after
endif

let g:mapleader = ","
let g:maplocalleader = "<Space>l"

nnoremap [exec] <Nop>
nmap <Space>x [exec]
nnoremap [others] <Nop>
nmap z [others]
nnoremap [keyword] <Nop>
nmap <Space>k [keyword]

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
let g:PHP_autoformatcomment = 0

runtime! rc/dein.vim

filetype plugin indent on
syntax on

augroup MyAuGroup
    autocmd!
augroup END

runtime! rc/local/*.vim
runtime! rc/init/*.vim
runtime! rc/plugins/dein/others.vim
runtime! rc/plugins/dein/fugitive_filetype_mapping.vim
runtime! rc/plugins/dein/unite_filetype_mapping.vim
if has("python3")
    set diffexpr=py3diff#diffexpr()
endif
