if has('win32') && has('vim_starting')
    set runtimepath^=~/.vim/
    set runtimepath+=~/.vim/after
endif

filetype off
filetype plugin indent off

runtime! rc/local/*.vim rc/local/*.lua

luafile ~/.vim/rc/option.lua
source ~/.vim/rc/autocmd.vim
luafile ~/.vim/rc/mapping.lua
try
    luafile ~/.vim/rc/plugins/_manager.lua
catch
    " avoid aborting
    echohl ErrorMsg
    echomsg v:exception
    echohl None
endtry

runtime! rc/local/after/*.vim rc/local/after/*.lua
