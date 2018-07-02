
let s:INDENT_MODE_NM = 'indent'
let s:INDENT_KEY = '[' . s:INDENT_MODE_NM . ']'

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()
let s:REMAP_KEY = notomo#mapping#get_remap_key()

function! s:convert_indent_style(to_hard, is_visual) abort
    let tmp_expandtab = &expandtab
    let expandtab_cmd = a:to_hard == 1 ? 'noexpandtab' : 'expandtab'
    execute 'setlocal ' . expandtab_cmd
    let range_str = a:is_visual == 1 ? "'<,'>" : '.'
    execute range_str . 'retab!'
    let &expandtab = tmp_expandtab
endfunction
nnoremap <silent> <Plug>(convert_indent_to_tab) :<C-u>call <SID>convert_indent_style(1, 0)<CR>
nnoremap <silent> <Plug>(convert_indent_to_space) :<C-u>call <SID>convert_indent_style(0, 0)<CR>
xnoremap <silent> <Plug>(convert_indent_to_tab) :<C-u>call <SID>convert_indent_style(1, 1)<CR>
xnoremap <silent> <Plug>(convert_indent_to_space) :<C-u>call <SID>convert_indent_style(0, 1)<CR>

function! s:indent_map(lhs, rhs, mode, remap) abort
    let remap = a:remap == 1 ? 'r' : ''
    call submode#enter_with(s:INDENT_MODE_NM , a:mode, remap, s:INDENT_KEY . a:lhs, a:rhs)
    call submode#map(s:INDENT_MODE_NM, a:mode, remap, a:lhs, a:rhs)
endfunction

function! notomo#indent#setup_submode(enter_key, is_visual) abort
    for info in notomo#mapping#indent_normal_mode()
        call s:indent_map(info[s:LHS_KEY], info[s:RHS_KEY], 'n', info[s:REMAP_KEY])
    endfor
    for info in notomo#mapping#indent_visual_mode()
        call s:indent_map(info[s:LHS_KEY], info[s:RHS_KEY], 'v', info[s:REMAP_KEY])
    endfor
    call submode#map(s:INDENT_MODE_NM, 'v', '', 'j', 'j')
    call submode#map(s:INDENT_MODE_NM, 'v', '', 'k', 'k')
    call submode#map(s:INDENT_MODE_NM, 'v', '', 'o', 'o')
    call submode#map(s:INDENT_MODE_NM, 'v', '', 'gg', 'gg')
    call submode#map(s:INDENT_MODE_NM, 'v', '', 'G', 'G')
    call submode#leave_with(s:INDENT_MODE_NM, 'nv', '', 'z')
    if a:is_visual
        execute 'normal! gv'
    endif
    call feedkeys(s:INDENT_KEY . a:enter_key) " enter submode
endfunction

