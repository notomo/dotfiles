let s:WINSIZE_MODE_NM = "winsize"

function! s:winsize_map(lhs, rhs) abort
    call submode#map(s:WINSIZE_MODE_NM, "n", "", a:lhs, a:rhs)
endfunction

function! tmno3#window#setup_submode(win_key, enter_key) abort
    call submode#enter_with(s:WINSIZE_MODE_NM, "n", "", a:win_key . a:enter_key, "<Nop>")
    call submode#leave_with(s:WINSIZE_MODE_NM, "n", "", "j")
    call s:winsize_map("a", "<C-w>>") " increace width
    call s:winsize_map("z", "<C-w><") " decreace width
    call s:winsize_map("u", "<C-w>+") " increace height
    call s:winsize_map("d", "<C-w>-") " decreace height
endfunction

