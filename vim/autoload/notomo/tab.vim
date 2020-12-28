
let s:TAB_MODE_NM = 'tab'
let s:TAB_KEY = '[' . s:TAB_MODE_NM . ']'

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()
let s:MAP_ONLY_KEY = notomo#mapping#get_map_only_key()
let s:REMAP_KEY = notomo#mapping#get_remap_key()

function! s:tab_map(lhs, rhs, map_only, remap) abort
    let remap = a:remap == 1 ? 'r' : ''
    if a:map_only
        if a:remap == 1
            silent execute join(['nmap', s:TAB_KEY . a:lhs, a:rhs])
            silent execute join(['xmap', s:TAB_KEY . a:lhs, a:rhs])
        else
            silent execute join(['nnoremap', s:TAB_KEY . a:lhs, a:rhs])
            silent execute join(['xnoremap', s:TAB_KEY . a:lhs, a:rhs])
        endif
    else
        call submode#enter_with(s:TAB_MODE_NM , 'nx', remap, s:TAB_KEY . a:lhs, a:rhs)
    endif
    call submode#map(s:TAB_MODE_NM, 'n', remap, a:lhs, a:rhs)
endfunction

function! notomo#tab#setup_submode(enter_key) abort
    for info in notomo#mapping#tab()
        call s:tab_map(info[s:LHS_KEY], info[s:RHS_KEY], info[s:MAP_ONLY_KEY], info[s:REMAP_KEY])
    endfor
    call submode#leave_with(s:TAB_MODE_NM, 'n', '', 'j')
    call feedkeys(s:TAB_KEY . a:enter_key) " enter submode
endfunction
