" タブ開閉・移動"{{{
let s:TAB_PREFIX_KEY = "<Leader>t"
let s:MOVE_TAB_PREFIX_KEY = "m"
nnoremap [tab] <Nop>
silent execute join(["nmap", s:TAB_PREFIX_KEY, "[tab]"])

" 新しい無名タブを開く
function! s:new_tab() abort
    tabe
    setlocal buftype=nofile noswapfile
endfunction
nnoremap <silent> <Plug>(new_none_tab) :<C-u>call <SID>new_tab()<CR>
" パスを指定して新しいタブで開く
nnoremap [tab]n :<C-u>tabe<Space>
" 前のバッファを新しいタブで開く
nnoremap <silent> [tab]b  :<C-u>tabe #<CR>
" 前にいたタブに移動
nnoremap <silent> [tab]p :<C-u>TabRecent<CR>

" タブ移動(マウスボタン用)
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
inoremap <C-Tab> <Esc>gt
inoremap <C-S-Tab> <Esc>gT

" タブを閉じる(マウスボタン用)
nnoremap <silent> <C-w> :<C-u>tabclose<CR>
inoremap <silent> <C-w> <ESC>:<C-u>tabclose<CR>
" 左側のタブを閉じる
function! s:close_left_tab() abort
    for i in range(2, tabpagenr())
        execute "1tabclose"
    endfor
endfunction
nnoremap <silent> <Plug>(close_left_tab) :<C-u>call <SID>close_left_tab()<CR>
nmap <silent> [tab]da <Plug>(close_left_tab)
" 右側のタブを閉じる
function! s:close_right_tab() abort
    for i in range(tabpagenr(),tabpagenr("$") - 1)
        execute "$tabclose"
    endfor
endfunction
nnoremap <silent> <Plug>(close_right_tab) :<C-u>call <SID>close_right_tab()<CR>
nmap <silent> [tab]dl <Plug>(close_right_tab)

" タブ移動モード設定
" [tab]lhs_suffixでモードに入る
function! s:tab_submode_mapping(lhs_suffix, rhs, map_only, is_remapped) abort
    let remap = a:is_remapped == 1 ? "r" : ""
    if a:map_only == 0
        call submode#enter_with('tab', 'n', remap, s:TAB_PREFIX_KEY . a:lhs_suffix, a:rhs)
    endif
    call submode#map('tab', 'n', remap, a:lhs_suffix, a:rhs)
endfunction
function! s:movetab_submode_mapping(lhs_suffix, rhs, map_only, is_remapped) abort
    call s:tab_submode_mapping(s:MOVE_TAB_PREFIX_KEY . a:lhs_suffix, a:rhs, a:map_only, a:is_remapped)
endfunction
" 新しい無名タブを開く
call s:tab_submode_mapping("t", "<Plug>(new_none_tab)", 0, 1)
" 右のタブに移動
call s:tab_submode_mapping("l", "gt", 0, 0)
" 右端のタブに移動
call s:tab_submode_mapping("s", ":<C-u>tabr<CR>", 0, 0)
" 左端のタブに移動
call s:tab_submode_mapping("e", ":<C-u>tabl<CR>", 0, 0)
" 左のタブに移動
call s:tab_submode_mapping("a", "gT", 0, 0)
call s:tab_submode_mapping("h", "gT", 0, 0)
" タブを閉じる
call s:tab_submode_mapping("q", ":<C-u>tabclose<CR>", 0, 0)
" 他のタブを閉じる
nnoremap <silent> [tab]o :<C-u>tabonly<CR>
" 左のタブを閉じる
call s:tab_submode_mapping("da", "<Plug>(close_left_tab)", 1, 1)
" 右のタブを閉じる
call s:tab_submode_mapping("dl", "<Plug>(close_right_tab)", 1, 1)
" 右に移動
call s:movetab_submode_mapping("l", ":<C-u>tabm+1<CR>", 0, 0)
" 右端に移動
call s:movetab_submode_mapping("s", ":<C-u>tabm 0<CR>", 0, 0)
" 左端に移動
call s:movetab_submode_mapping("e", ":<C-u>tabm<CR>", 0, 0)
" 左に移動
call s:movetab_submode_mapping("a", ":<C-u>tabm-1<CR>", 0, 0)
call s:movetab_submode_mapping("h", ":<C-u>tabm+1<CR>", 0, 0)

call submode#leave_with('tab', 'n', '', 'j')
"}}}
