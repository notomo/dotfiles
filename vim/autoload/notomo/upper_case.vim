
let s:UPPSER_CASE_MODE_NM = '[upper_case]'
let s:UPPSER_CASE_KEY = notomo#mapping#get_upper_case_mode_key()
let s:EXIT_KEY = ';'

let s:init = v:true

function! notomo#upper_case#setup_submode() abort
    let chars = map(range(0,25), {key, val -> nr2char(char2nr('a') + val)})
    for char in chars
        call submode#map(s:UPPSER_CASE_MODE_NM, 'ci', '', char, toupper(char) . '<C-r>=notomo#upper_case#exit()<CR>')
    endfor
    call submode#enter_with(s:UPPSER_CASE_MODE_NM, 'ci', '', s:UPPSER_CASE_KEY, '<Nop>')
    call submode#leave_with(s:UPPSER_CASE_MODE_NM, 'ci', '', s:EXIT_KEY)

    let tmp_enter_key = notomo#mapping#get_sub_input_key()  . 'N'
    call submode#enter_with(s:UPPSER_CASE_MODE_NM, 'ci', '', tmp_enter_key, '<Nop>')
    call feedkeys(tmp_enter_key)
    return ''
endfunction

function! notomo#upper_case#exit() abort
    if s:init
        let s:init = v:false
        return ''
    endif
    call feedkeys(s:EXIT_KEY)
    return ''
endfunction
