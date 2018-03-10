
let s:CTRL_MODE_NM = '[ctrl]'
let s:CTRL_KEY = notomo#mapping#get_ctrl_mode_key()
let s:EXIT_KEY = ';'

function! notomo#ctrl#setup_submode() abort
    let chars = map(range(0,25), {key, val -> nr2char(char2nr('a') + val)})
    for char in chars
        call submode#map(s:CTRL_MODE_NM, 'ci', 'r', char, '<C-' . char . '><C-r>=notomo#ctrl#exit()<CR>')
    endfor
    call submode#enter_with(s:CTRL_MODE_NM, 'ci', '', s:CTRL_KEY, '<Nop>')
    call submode#leave_with(s:CTRL_MODE_NM, 'ci', '', s:EXIT_KEY)

    let tmp_enter_key = notomo#mapping#get_sub_input_key()  . 'N'
    call submode#enter_with(s:CTRL_MODE_NM, 'ci', '', tmp_enter_key, '<Nop>')
    call feedkeys(tmp_enter_key)
    return ''
endfunction

function! notomo#ctrl#exit() abort
    call feedkeys(s:EXIT_KEY)
    return ''
endfunction
