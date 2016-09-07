" タブ開閉・移動
let s:TAB_PREFIX_KEY = "<Leader>t"
nnoremap [tab] <Nop>
silent execute join(["nmap", s:TAB_PREFIX_KEY, "[tab]"])

" 新しい無名タブを開く
function! s:new_tab() abort
    tabe
    setlocal buftype=nofile noswapfile
endfunction
nnoremap <silent> [tab]t  :<C-u>call <SID>new_tab()<CR>
" パスを指定して新しいタブで開く
nnoremap [tab]n :<C-u>tabe<Space>
" 前のバッファを新しいタブで開く
nnoremap <silent> [tab]b  :<C-u>tabe #<CR>
" 前にいたタブに移動
nnoremap <silent> [tab]p :<C-u>TabRecent<CR>

" タブ移動モード設定
" [tab]lhs_suffixでモードに入る
function! s:tab_submode_mapping(lhs_suffix, rhs) abort
    call submode#enter_with('tab', 'n', '', s:TAB_PREFIX_KEY . a:lhs_suffix, a:rhs)
    call submode#map('tab', 'n', '', a:lhs_suffix, a:rhs)
endfunction
" 右のタブに移動
call s:tab_submode_mapping("l", "gt")
" 右端のタブに移動
call s:tab_submode_mapping("s", ":<C-u>tabr<CR>")
" 左端のタブに移動
call s:tab_submode_mapping("e", ":<C-u>tabl<CR>")
" 端のタブに移動
call s:tab_submode_mapping("a", "gT")
" タブを閉じる
call s:tab_submode_mapping("q", ":<C-u>tabclose<CR>")

" タブ移動(マウスボタン用)
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
inoremap <C-Tab> <Esc>gt
inoremap <C-S-Tab> <Esc>gT

" タブを閉じる
function! s:close_tab() abort
    try
        execute "tabclose"
    catch
        if !getbufvar("%","&mod")
            execute "q"
        else
            echomsg "Not saved"
        endif
    endtry
endfunction
nnoremap <silent> [tab]q :<C-u>call <SID>close_tab()<CR>
" タブを閉じる(マウスボタン用)
nnoremap <silent> <C-w> :<C-u>call <SID>close_tab()<CR>
inoremap <silent> <C-w> <ESC>:<C-u>call <SID>close_tab()<CR>
" 左側のタブを閉じる
function! s:close_left_tab() abort
    let current_tab_number = tabpagenr()
    for i in range(2,current_tab_number)
        execute "1tabclose"
    endfor
endfunction
nnoremap <silent> [tab]da :<C-u>call <SID>close_left_tab()<CR>
" 右側のタブを閉じる
function! s:close_right_tab() abort
    let current_tab_number = tabpagenr()
    let last_tab_number = tabpagenr("$")
    for i in range(current_tab_number,last_tab_number-1)
        execute "$tabclose"
    endfor
endfunction
nnoremap <silent> [tab]dl :<C-u>call <SID>close_right_tab()<CR>
" 他のタブを閉じる
nnoremap <silent> [tab]o :<C-u>tabo<CR>


" タブを移動
let s:MOVE_TAB_PREFIX_KEY = s:TAB_PREFIX_KEY . "m"
nnoremap [movetab] <Nop>
silent execute join(["nmap", s:MOVE_TAB_PREFIX_KEY, "[movetab]"])

" タブ自体の移動モード設定
" [movetab]lhs_suffixでモードに入る
function! s:movetab_submode_mapping(lhs_suffix, rhs) abort
    call submode#enter_with('movetab', 'n', '', s:MOVE_TAB_PREFIX_KEY . a:lhs_suffix, a:rhs)
    call submode#map('movetab', 'n', '', a:lhs_suffix, a:rhs)
endfunction
" 右のタブに移動
call s:movetab_submode_mapping("l", ":<C-u>tabm+1<CR>")
" 右端のタブに移動
call s:movetab_submode_mapping("s", ":<C-u>tabm 0<CR>")
" 左端のタブに移動
call s:movetab_submode_mapping("e", ":<C-u>tabm<CR>")
" 端のタブに移動
call s:movetab_submode_mapping("a", ":<C-u>tabm-1<CR>")

