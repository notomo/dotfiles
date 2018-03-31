
let s:UPPER = 'UPPER'
let s:SNAKE = 'SNAKE'
let s:CAMEL = 'CAMEL'
let s:PASKAL = 'PASKAL'
let s:OTHER = 'OTHER'

function! s:convert(case_type, word) abort
    let mapper = {
        \ s:UPPER : {word -> notomo#case#to_upper(word)},
        \ s:SNAKE : {word -> notomo#case#to_snake(word)},
        \ s:CAMEL : {word -> notomo#case#to_camel(word)},
        \ s:PASKAL : {word -> notomo#case#to_paskal(word)},
        \ s:OTHER : {word -> word},
    \ }
    return mapper[a:case_type](a:word)
endfunction

function! notomo#case#substitute_helper(snake_equal_camel, match, word) abort
    let case_type = s:get_type(a:match)
    if a:snake_equal_camel && (case_type ==? s:SNAKE || case_type ==? s:CAMEL)
        let case_type = s:get_type(a:word)
    endif
    return s:convert(case_type, a:word)
endfunction

function! notomo#case#substitute_pattern(word) abort
    let patterns = map([s:UPPER, s:SNAKE, s:CAMEL, s:PASKAL], {key, type -> s:convert(type, a:word)})
    let snake_equal_camel = patterns[1] ==# patterns[2] ? '1' : '0'
    let pattern = join(patterns, '|')
    return 's/\v(' . pattern . ')/\=notomo#case#substitute_helper(' . snake_equal_camel . ', submatch(0), "")/g' . "\<Left>\<Left>\<Left>\<Left>"
endfunction

function! s:get_type(str) abort
    if s:is_upper(a:str)
        return s:UPPER
    elseif s:is_snake(a:str)
        return s:SNAKE
    elseif s:is_camel(a:str)
        return s:CAMEL
    elseif s:is_paskal(a:str)
        return s:PASKAL
    endif
    return s:OTHER
endfunction

function! notomo#case#to_snake(str) abort
    let case_type = s:get_type(a:str)
    if case_type ==? 'camel'
        return substitute(a:str, '\v(\u)', '_\l\1', 'g')
    elseif case_type ==? 'paskal'
        let str = tolower(a:str[0]) . a:str[1:]
        return substitute(str, '\v(\u)', '_\l\1', 'g')
    endif
    return tolower(a:str)
endfunction

function! notomo#case#to_camel(str) abort
    let case_type = s:get_type(a:str)
    let str = a:str
    if case_type ==? 'paskal'
        return tolower(str[0]) . str[1:]
    elseif case_type ==? 'camel'
        return str
    endif
    return substitute(tolower(str), '\v_(.)', '\u\1', 'g')
endfunction

function! notomo#case#to_paskal(str) abort
    let str = notomo#case#to_camel(a:str)
    return toupper(str[0]) . str[1:]
endfunction

function! notomo#case#to_upper(str) abort
    return toupper(notomo#case#to_snake(a:str))
endfunction

function! s:is_upper(str) abort
    return a:str ==# toupper(a:str)
endfunction

function! s:is_snake(str) abort
    return a:str ==# tolower(a:str)
endfunction

function! s:is_camel(str) abort
    return a:str =~# '\v^\l+(\u\l+)+'
endfunction

function! s:is_paskal(str) abort
    return a:str =~# '\v^(\u\l+)+'
endfunction


