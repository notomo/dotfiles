
let s:TAB_MODE_NM = 'tab'
let s:TAB_KEY = '[' . s:TAB_MODE_NM . ']'

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()
let s:MAP_ONLY_KEY = notomo#mapping#get_map_only_key()
let s:REMAP_KEY = notomo#mapping#get_remap_key()

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

function! notomo#tab#lock() abort
    let bufnr = bufnr('%')
    let bufname = bufname('%')
    execute printf('autocmd MyAuGroup TabClosed <buffer=%s> call s:reopen(%s, "%s")', bufnr, bufnr, bufname)
endfunction

function! notomo#tab#unlock() abort
    execute printf('autocmd! MyAuGroup TabClosed <buffer=%s>', bufnr('%'))
endfunction

function! s:reopen(bufnr, _bufname) abort
    if !bufexists(a:bufnr)
        return notomo#tab#unlock()
    endif

    tabedit | execute 'buffer' a:bufnr
endfunction
