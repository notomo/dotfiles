
function! notomo#go#next() abort
    call s:go_to_function('next', 0)
endfunction

function! notomo#go#prev() abort
    call s:go_to_function('prev', -1)
endfunction

function! s:go_to_function(next_prev, offset) abort
    let path = expand('%:p')
    let offset = s:get_line_offset(a:offset)
    let result = systemlist(['motion', '-mode', a:next_prev, '-offset', offset, '-file', path])
    let info = json_decode(join(result, ''))
    if has_key(info, 'err')
        return
    endif

    let pos = info['func']['func']
    execute 'normal! ' . pos['line'] . 'gg'
endfunction

function! s:get_line_offset(offset) abort
    let line = line('.') + a:offset
    return line2byte(line) - 1
endfunction
