
set encoding=utf-8
scriptencoding utf-8
let $LANG='ja_JP.UTF-8'

if has('vim_starting')
    set runtimepath^=~/.vim/
    set runtimepath+=~/.vim/after
    if has('kaoriya')
        set runtimepath+=$VIM/plugins/kaoriya
        source $VIM/plugins/kaoriya/encode_japan.vim
    endif
endif

filetype off
filetype plugin indent off

runtime! rc/dein/dein.vim

syntax on
filetype plugin indent on

if !has('vim_starting')
    call dein#call_hook('source')
    call dein#call_hook('post_source')
endif

runtime! rc/local/*.vim
runtime! rc/base/*.vim
if has('nvim')
    runtime! rc/neovim/*.vim
endif

runtime! rc/plugins/unite_filetype_mapping.vim

runtime! rc/local/after/*.vim

