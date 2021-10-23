filetype off
filetype plugin indent off

runtime! rc/local/*.vim rc/local/*.lua

luafile ~/.vim/rc/option.lua
source ~/.vim/rc/autocmd.vim
source ~/.vim/rc/mapping.vim
try
    luafile ~/.vim/rc/plugins/_manager.lua
catch
    " avoid aborting
    echohl ErrorMsg
    echomsg v:exception
    echohl None
endtry

runtime! rc/local/after/*.vim rc/local/after/*.lua
