
function! tmno3#vimrc#exchange() abort
    let pos = getpos(".")
    execute 's/\v%#(\_.)(\_.)/\2\1/g'
    call setpos('.', pos)
    normal! l
endfunction
