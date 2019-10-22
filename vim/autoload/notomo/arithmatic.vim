
function! notomo#arithmatic#inc_dec(inc_or_dec) abort
    if a:inc_or_dec ==? 'inc'
        let command = "\<C-a>"
    else
        let command = "\<C-x>"
    endif
    let line = getline('.')
    let pos = getpos('.')
    let column = pos[2]
    let target = line[column - 1:]
    let index = matchend(target, '\v(-)?\d+\ze[^[:digit:]]*$')
    if index == -1
        let target = line[:column - 1]
        let index = matchend(target, '\v(-)?\d+\ze[^[:digit:]]*$')
        if index != -1
            return column - index . 'h' . command
        endif
    endif
    return command
endfunction
