
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
        call s:wrap_move('lnext', 'lfirst')
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

function! s:current_open(is_preview) abort
    let qf_type = s:get_current_qf_type()
    let entries = s:get_entries(qf_type)
    if empty(entries)
        return
    endif
    if qf_type == s:QUICK_FIX_TYPE
        execute 'cc ' . line('.')
    elseif qf_type == s:LOC_LIST_TYPE
        execute 'll ' . line('.')
    endif
    if a:is_preview
        execute "normal! zz\<C-w>p"
    endif
endfunction

function! tmno3#qf#current_open() abort
    call s:current_open(0)
endfunction

function! tmno3#qf#preview() abort
    call s:current_open(1)
endfunction

function! s:get_history(qf_type) abort
    if a:qf_type == s:QUICK_FIX_TYPE
        return get(w:, 'qf_history', [])
    elseif a:qf_type == s:LOC_LIST_TYPE
        return get(w:, 'loc_history', [])
    endif
endfunction

function! s:set_history(qf_type, entry_history) abort
    if a:qf_type == s:QUICK_FIX_TYPE
        let w:qf_history = a:entry_history
    elseif a:qf_type == s:LOC_LIST_TYPE
        let w:loc_history = a:entry_history
    endif
endfunction

function! s:set_entries(qf_type, entries, flag) abort
    if a:qf_type == s:QUICK_FIX_TYPE
        call setqflist(a:entries, a:flag)
    elseif a:qf_type == s:LOC_LIST_TYPE
        call setloclist(0, a:entries, a:flag)
    endif
endfunction

function! s:get_entries(qf_type) abort
    if a:qf_type == s:QUICK_FIX_TYPE
        return getqflist()
    elseif a:qf_type == s:LOC_LIST_TYPE
        return getloclist(0)
    endif
endfunction

function! tmno3#qf#delete() abort
    let qf_type = s:get_current_qf_type()
    let entries = s:get_entries(qf_type)
    if empty(entries)
        return
    endif
    let entry_history = s:get_history(qf_type)
    call add(entry_history, copy(entries))
    call s:set_history(qf_type, entry_history)
    unlet! entries[line('.') - 1]
    call s:set_entries(qf_type, entries, 'r')
endfunction

function! tmno3#qf#undo() abort
    let qf_type = s:get_current_qf_type()
    let entry_history = s:get_history(qf_type)
    if empty(entry_history)
        return
    endif
    call s:set_entries(qf_type, remove(entry_history, -1), 'r')
endfunction
