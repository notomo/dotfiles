
function! tmno3#vimrc#exchange() abort
    let pos = getpos('.')
    execute 's/\v%#(\_.)(\_.)/\2\1/g'
    call setpos('.', pos)
    normal! l
endfunction

function! tmno3#vimrc#timer_start() abort
    let g:start_time = reltime()
endfunction

function! tmno3#vimrc#timer_end() abort
    echomsg reltimestr(reltime(g:start_time)) | unlet g:start_time
endfunction

function! tmno3#vimrc#cd_current() abort
    cd %:p:h
endfunction

function! tmno3#vimrc#syntax_report() abort
    syntime on
    redraw!
    syntime off
    Capture syntime report
endfunction
