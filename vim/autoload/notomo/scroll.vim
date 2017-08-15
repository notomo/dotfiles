let s:SCROLL_MODE_NM = 'scroll'
let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()

function! notomo#scroll#scroll(cmd) abort
    noautocmd execute "normal! \<C-w>w"
    execute 'keepjumps normal! ' . a:cmd
    noautocmd execute "normal! \<C-w>p"
endfunction

function! s:scroll_map(lhs, rhs) abort
    call submode#map(s:SCROLL_MODE_NM, 'n', 's', a:lhs, ":call notomo#scroll#scroll('" . a:rhs . "')<CR>")
endfunction

function! notomo#scroll#setup_submode(enter_key) abort
    call submode#enter_with(s:SCROLL_MODE_NM, 'n', '', a:enter_key, '<Nop>')
    call submode#leave_with(s:SCROLL_MODE_NM, 'n', '', '<Space>')
    call s:scroll_map('j', '<C-v><C-e>')
    call s:scroll_map('k', '<C-v><C-y>')
    call s:scroll_map('J', '<C-v><C-d>')
    call s:scroll_map('K', '<C-v><C-u>')
    call s:scroll_map('H', 'zH')
    call s:scroll_map('L', 'zL')
    call s:scroll_map('h', 'zh')
    call s:scroll_map('l', 'zl')
    call s:scroll_map('gg', 'gg')
    call s:scroll_map('G', 'G')
    call feedkeys(a:enter_key)
endfunction

