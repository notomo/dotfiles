let s:WINSIZE_MODE_NM = 'winsize'

function! s:winsize_map(lhs, rhs) abort
    call submode#map(s:WINSIZE_MODE_NM, 'n', '', a:lhs, a:rhs)
endfunction

function! tmno3#window#setup_submode(win_key, enter_key) abort
    call submode#enter_with(s:WINSIZE_MODE_NM, 'n', '', a:win_key . a:enter_key, '<Nop>') " overwrite the key mapping calling this function
    call submode#leave_with(s:WINSIZE_MODE_NM, 'n', '', 'j')
    call s:winsize_map('a', '<C-w>>') " increace width
    call s:winsize_map('z', '<C-w><') " decreace width
    call s:winsize_map('h', '<C-w>+') " increace height
    call s:winsize_map('l', '<C-w>-') " decreace height
    call feedkeys(a:win_key . a:enter_key) " enter submode
endfunction

