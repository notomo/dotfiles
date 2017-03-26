
let s:QUICK_FIX_TYPE = 1
let s:LOC_LIST_TYPE = 2
let s:NONE_TYPE = 3

function! s:get_qf_type() abort
    let current_qf_type = s:get_current_qf_type()
    if current_qf_type != s:NONE_TYPE
        return current_qf_type
    endif
    let loclist = getloclist(0)
    if len(loclist) != 0
        return s:LOC_LIST_TYPE
    endif
    let qflist = getqflist()
    if len(qflist) != 0
        return s:QUICK_FIX_TYPE
    endif
    echomsg 'No errors'
    return s:NONE_TYPE
endfunction

function! s:get_current_qf_type() abort
    let is_qf_type = &filetype ==# 'qf' ? 1 : 0
    if is_qf_type
        let window = getwininfo(win_getid())[0]
        return window.quickfix ? s:QUICK_FIX_TYPE : s:LOC_LIST_TYPE
    endif
    return s:NONE_TYPE
endfunction

function! tmno3#qf#open() abort
    let qf_type = s:get_qf_type()
    if qf_type == s:QUICK_FIX_TYPE
        copen
    elseif qf_type == s:LOC_LIST_TYPE
        lopen
    endif
endfunction

function! tmno3#qf#close() abort
    let qf_type = s:get_qf_type()
    if qf_type == s:QUICK_FIX_TYPE
        cclose
    elseif qf_type == s:LOC_LIST_TYPE
        lclose
    endif
endfunction

function! tmno3#qf#first() abort
    let qf_type = s:get_qf_type()
    if qf_type == s:QUICK_FIX_TYPE
        cfirst
    elseif qf_type == s:LOC_LIST_TYPE
        lfirst
    endif
endfunction

function! tmno3#qf#last() abort
    let qf_type = s:get_qf_type()
    if qf_type == s:QUICK_FIX_TYPE
        clast
    elseif qf_type == s:LOC_LIST_TYPE
        llast
    endif
endfunction

function! s:wrap_move(try_cmd, catch_cmd) abort
    try
        execute a:try_cmd
    catch /^Vim\%((\a\+)\)\=:E553/
        execute a:catch_cmd
    endtry
endfunction

function! tmno3#qf#next() abort
    let qf_type = s:get_qf_type()
    if qf_type == s:QUICK_FIX_TYPE
        call s:wrap_move('cnext', 'cfirst')
    elseif qf_type == s:LOC_LIST_TYPE
        call s:wrap_move('lcnext', 'lfirst')
    endif
endfunction

function! tmno3#qf#previous() abort
    let qf_type = s:get_qf_type()
    if qf_type == s:QUICK_FIX_TYPE
        call s:wrap_move('cprevious', 'clast')
    elseif qf_type == s:LOC_LIST_TYPE
        call s:wrap_move('lprevious', 'llast')
    endif
endfunction

function! tmno3#qf#current_open(is_preview) abort
    let qf_type = s:get_current_qf_type()
    if qf_type == s:QUICK_FIX_TYPE
        execute 'cc ' . line('.')
    elseif qf_type == s:LOC_LIST_TYPE
        execute 'll ' . line('.')
    else
        return
    endif
    if a:is_preview
        execute "normal! zz\<C-w>p"
    endif
endfunction


