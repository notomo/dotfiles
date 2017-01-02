
let s:START_LINE_KEY = "sl"
let s:START_CHAR_KEY = "sc"
let s:END_LINE_KEY = "el"
let s:END_CHAR_KEY = "ec"
if !exists('g:mark_chars')
    let g:mark_chars = split("abcdefghijklmnopqrstuvwxyz", "\\zs")
endif

function! tmno3#mark#delete_all() abort
    delmark!
    let b:mark_index = -1
    echomsg "deleted all marks"
endfunction

function! tmno3#mark#to_previous() abort
    let info = s:mark_info()
    if info[s:START_CHAR_KEY] != "" && line(".") <= info[s:START_LINE_KEY]
        return "\'" . info[s:END_CHAR_KEY]
    elseif info[s:START_CHAR_KEY] != ""
        return "[\'"
    endif
endfunction

function! tmno3#mark#to_next() abort
    let info = s:mark_info()
    if info[s:END_CHAR_KEY] != "" && line(".") >= info[s:END_LINE_KEY]
        return "\'" . info[s:START_CHAR_KEY]
    elseif info[s:END_CHAR_KEY] != ""
        return "]\'"
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

function! s:mark_info() abort
    let start_pos = line("$")
    let end_pos = 1
    let start_char = ""
    let end_char = ""
    for c in g:mark_chars
        let line_num = line("'" . c)
        if line_num == 0
            continue
        endif
        if line_num <= start_pos
            let start_pos = line_num
            let start_char = c
        endif
        if line_num >= end_pos
            let end_pos = line_num
            let end_char = c
        endif
    endfor
    return {s:START_LINE_KEY : start_pos, s:START_CHAR_KEY : start_char, s:END_LINE_KEY : end_pos, s:END_CHAR_KEY : end_char}
endfunction

