
set encoding=utf-8
scriptencoding utf-8
let $LANG='ja_JP.UTF-8'

if has('vim_starting')
    set runtimepath+=~/.vim/
    set runtimepath+=~/.vim/after
    set runtimepath+=$VIM/plugins/kaoriya
endif

filetype off
filetype plugin indent off

let g:mapleader = ','
let g:maplocalleader = '<Leader>l'
let g:ft_ignroe_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\|log\)$'

nnoremap [exec] <Nop>
nmap <Space>x [exec]
vnoremap [exec] <Nop>
vmap <Space>x [exec]
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
noremap [operator] <Nop>
map <Space><Leader> [operator]

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

runtime! rc/dein/dein.vim

augroup MyAuGroup
    autocmd!
augroup END

set guioptions+=M
syntax on
filetype plugin indent on

if !has('vim_starting')
    call dein#call_hook('source')
    call dein#call_hook('post_source')
endif

runtime! rc/local/*.vim
runtime! rc/init/*.vim
if has('nvim')
    runtime! rc/neovim/*.vim
endif
runtime! rc/plugins/others.vim
runtime! rc/plugins/fugitive_filetype_mapping.vim
runtime! rc/plugins/unite_filetype_mapping.vim
runtime! rc/local/after/*.vim
if has('python3')
    set diffexpr=py3diff#diffexpr()
endif

