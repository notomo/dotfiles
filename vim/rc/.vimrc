
scriptencoding utf-8
let $LANG='ja_JP.UTF-8'
set encoding=utf-8

if has('vim_starting')
    set runtimepath+=~/.vim/
    " set runtimepath+=~/.vim/dein/repos/github.com/*
    set runtimepath+=~/.vim/after
    set runtimepath+=$VIM/plugins/vimdoc-ja
endif

let g:mapleader = ","
let g:maplocalleader = "<Leader>l"

nnoremap [exec] <Nop>
nmap <Space>x [exec]
vnoremap [exec] <Nop>
vmap <Space>x [exec]
nnoremap [others] <Nop>
nmap z [others]
nnoremap [keyword] <Nop>
nmap <Space>k [keyword]
nnoremap [diff] <Nop>
nmap <Leader>d [diff]
vnoremap [diff] <Nop>
vmap <Leader>d [diff]
nnoremap [edit] <Nop>
nmap <Space>e [edit]
vnoremap [edit] <Nop>
vmap <Space>e [edit]
nnoremap [file] <Nop>
nmap <Space>f [file]

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
let g:loaded_spellfile_plugin  = 1
let g:loaded_logiPat           = 1
let g:PHP_autoformatcomment = 0

runtime! rc/dein.vim

augroup MyAuGroup
    autocmd!
augroup END

set guioptions+=M
filetype plugin indent on
syntax on

runtime! rc/local/*.vim
runtime! rc/init/*.vim
runtime! rc/plugins/others.vim
runtime! rc/plugins/fugitive_filetype_mapping.vim
runtime! rc/plugins/unite_filetype_mapping.vim
if has("python3")
    set diffexpr=py3diff#diffexpr()
endif

