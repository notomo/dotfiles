
if !exists('g:mark_chars')
    let g:mark_chars = split('abcdefghijklmnopqrstuvwxyz', '\\zs')
endif

function! tmno3#mark#delete_all() abort
    delmark!
    let b:mark_index = -1
    echomsg 'deleted all marks'
endfunction

function! tmno3#mark#to_previous() abort
    let end_pos = 0
    let curline_num = line('.')
    for c in g:mark_chars
        let line_num = line("'" . c)
        if line_num == 0
            continue
        elseif line_num < curline_num
            return "[\'"
        else
            if end_pos < line_num
                let end_pos = line_num
                let end_char = c
            endif
        endif
    endfor
    if end_pos != 0
        return "\'" . end_char
    endif
endfunction

function! tmno3#mark#to_next() abort
    let start_pos = line('$')
    let start_char = ''
    let curline_num = line('.')
    for c in g:mark_chars
        let line_num = line("'" . c)
        if line_num == 0
            continue
        elseif line_num > curline_num
            return "]\'"
        else
            if start_pos > line_num
                let start_pos = line_num
                let start_char = c
            endif
        endif
    endfor
    if start_char !=? ''
        return "\'" . start_char
    endif
endfunction

function! tmno3#mark#set() abort
    if !exists('b:mark_index')
        let b:mark_index = 0
    else
        let b:mark_index = (b:mark_index + 1) % len(g:mark_chars)
    endif
    let mark_char = g:mark_chars[b:mark_index]
    execute 'mark' mark_char
    echomsg 'marked' mark_char
endfunction
