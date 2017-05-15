
let s:TAB_MODE_NM = 'tab'
let s:TAB_KEY = '[' . s:TAB_MODE_NM . ']'

let s:LHS_KEY = tmno3#mapping#get_lhs_key()
let s:RHS_KEY = tmno3#mapping#get_rhs_key()
let s:MAP_ONLY_KEY = tmno3#mapping#get_map_only_key()
let s:REMAP_KEY = tmno3#mapping#get_remap_key()

" open new tab"{{{
function! s:new_tab() abort
    tabe | setlocal buftype=nofile noswapfile fileformat=unix
endfunction
nnoremap <silent> <Plug>(new_tab) :<C-u>call <SID>new_tab()<CR>
"}}}

" close left tabs"{{{
function! s:tabclose_l() abort
    for i in range(2, tabpagenr())
        execute '1tabclose'
    endfor
endfunction
nnoremap <silent> <Plug>(tabclose_l) :<C-u>call <SID>tabclose_l()<CR>
"}}}

" close right tabs"{{{
function! s:tabclose_r() abort
    for i in range(tabpagenr(),tabpagenr('$') - 1)
        execute '$tabclose'
    endfor
endfunction
nnoremap <silent> <Plug>(tabclose_r) :<C-u>call <SID>tabclose_r()<CR>
"}}}

function! s:separate_tab(tabnum) abort
    if a:tabnum < 1 || a:tabnum > tabpagenr('$')
        return
    endif
    let tab_bufs = tabpagebuflist(a:tabnum)
    if len(tab_bufs) < 2
        return
    endif
    let curtab = tabpagenr()
    execute 'noautocmd tabnext ' . a:tabnum
    for bufnum in tab_bufs
        noautocmd tabnew
        execute 'noautocmd buffer ' . bufnum
    endfor
    execute 'tabclose ' . a:tabnum
    execute 'noautocmd tabnext ' . curtab
endfunction
function! s:separate_left_tab() abort
    call s:separate_tab(tabpagenr() + 1)
endfunction
nnoremap [tab]L :<C-u>call <SID>separate_left_tab()<CR>

function! s:tab_map(lhs, rhs, map_only, remap) abort
    let remap = a:remap == 1 ? 'r' : ''
    if a:map_only
        if a:remap == 1
            silent execute join(['nmap', s:TAB_KEY . a:lhs, a:rhs])
            silent execute join(['vmap', s:TAB_KEY . a:lhs, a:rhs])
        else
            silent execute join(['nnoremap', s:TAB_KEY . a:lhs, a:rhs])
            silent execute join(['vnoremap', s:TAB_KEY . a:lhs, a:rhs])
        endif
    else
        call submode#enter_with(s:TAB_MODE_NM , 'nv', remap, s:TAB_KEY . a:lhs, a:rhs)
    endif
    call submode#map(s:TAB_MODE_NM, 'n', remap, a:lhs, a:rhs)
endfunction

function! tmno3#tab#setup_submode(enter_key) abort
    for info in tmno3#mapping#tab()
        call s:tab_map(info[s:LHS_KEY], info[s:RHS_KEY], info[s:MAP_ONLY_KEY], info[s:REMAP_KEY])
    endfor
    call submode#leave_with('tab', 'n', '', 'j')
    call feedkeys('[tab]' . a:enter_key) " enter submode
endfunction

