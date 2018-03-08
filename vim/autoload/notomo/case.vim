
let s:UPPSER_CASE_MODE_NM = '[case]'
let s:UPPSER_CASE_KEY = 'jkl'

function! notomo#case#setup_submode() abort
    let chars = map(range(0,25), {key, val -> nr2char(char2nr('a') + val)})
    for char in chars
        call submode#map(s:UPPSER_CASE_MODE_NM, 'ci', '', char, toupper(char) . '<C-r>=notomo#case#feedkeys()<CR>')
    endfor
    call submode#enter_with(s:UPPSER_CASE_MODE_NM, 'ci', '', s:UPPSER_CASE_KEY, '<Nop>')
    call submode#leave_with(s:UPPSER_CASE_MODE_NM, 'ci', '', 'j')
    call feedkeys(s:UPPSER_CASE_KEY) " enter submode
    return ''
endfunction

function! notomo#case#feedkeys() abort
    call feedkeys('j')
    return ''
endfunction
