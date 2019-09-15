
function! notomo#rust#next() abort
    call s:goto('next', 0)
endfunction

function! notomo#rust#prev() abort
    call s:goto('prev', -1)
endfunction

function! s:goto(next_prev, offset) abort
    if a:next_prev ==# 'next'
        let flags = ''
    else
        let flags = 'b'
    endif
    call search('\v^\s*\zsfn', flags)
endfunction
