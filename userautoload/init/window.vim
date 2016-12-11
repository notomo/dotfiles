"ウィンドウ移動"{{{
let s:WINMOVE_PREFIX_KEY = "m"
nnoremap [winmove] <Nop>
silent execute join(["nmap", s:WINMOVE_PREFIX_KEY, "[winmove]"])

" 左
nnoremap [winmove]a <C-w>h
" 下
nnoremap [winmove]j <C-w>j
nnoremap [winmove]x <C-w>j
" 上
nnoremap [winmove]k <C-w>k
nnoremap [winmove]w <C-w>k
" 右
nnoremap [winmove]l <C-w>l
" 次
nnoremap [winmove]n <C-w><C-w>
" 前
nnoremap [winmove]p <C-w>p
" 入れ替え
nnoremap [winmove]r <C-w>r
"}}}

"ウィンドウ分割・解除"{{{
nnoremap [window] <Nop>
nmap <Space>s [window]

" 横分割
nnoremap [window]h :<C-u>split<CR>
" 縦分割
nnoremap [window]v :<C-u>vsplit<CR>
" 分割解除
nnoremap [window]o :<C-u>only<CR>
" プレビューウィンドウを閉じる
nnoremap [window]p <C-w>z
"}}}

" ウィンドウサイズ変更"{{{
let s:WINSIZE_PREFIX_KEY = s:WINMOVE_PREFIX_KEY . "m"
nnoremap [winsize] <Nop>
silent execute join(["nmap", s:WINSIZE_PREFIX_KEY, "[winsize]"])

" ウィンドウサイズ変更モード設定
" [winsize]lhs_suffixでモードに入る
" モード内ではlhs_suffixのみで動作
function! s:winsize_submode_mapping(lhs_suffix, rhs) abort
    call submode#enter_with('winsize', 'n', '', s:WINSIZE_PREFIX_KEY . a:lhs_suffix, a:rhs)
    call submode#map('winsize', 'n', '', a:lhs_suffix, a:rhs)
endfunction
" 横幅を増やす
call s:winsize_submode_mapping("a", "<C-w>>")
" 横幅を減らす
call s:winsize_submode_mapping("z", "<C-w><")
" 縦幅を増やす
call s:winsize_submode_mapping("h", "<C-w>+")
" 縦幅を減らす
call s:winsize_submode_mapping("l", "<C-w>-")

call submode#leave_with('winsize', 'n', '', 'j')

" 均等化
nnoremap [winsize]e  <C-w>=
" 最大化
nnoremap [winsize]m :<C-u>SM 4<CR>
" 最大化を解除
nnoremap [winsize]r :<C-u>SM 0<CR>
"}}}
