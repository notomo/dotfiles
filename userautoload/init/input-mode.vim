
" 移動
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-S-b> <C-Left>
inoremap <C-S-f> <C-Right>
inoremap <C-a> <C-r>=MyExecExCommand('normal ^')<CR>
inoremap <C-e> <END>

" 編集
inoremap <C-o> <C-g>u<C-r>=MyExecExCommand('normal o')<CR>
inoremap <C-S-j> <C-g>u<C-r>=MyExecExCommand('normal! J')<CR>
inoremap <C-S-d> <C-g>u<C-r>=MyExecExCommand('normal! D','onemore')<CR>
inoremap <C-b> <BS>
inoremap <C-d> <Del>
inoremap <C-v> <C-r>"

" undo redo
inoremap <C-S-u> <C-g>u<C-r>=MyExecExCommand('undo', 'onemore')<CR>
inoremap <C-S-r> <C-r>=MyExecExCommand('redo', 'onemore')<CR>

" インデント
inoremap <TAB> <C-t>
inoremap <S-TAB> <C-d>

" 電卓
inoremap <C-S-c> <C-r>=

" 日本語入力固定切り替え
inoremap <F10> <C-^><C-r>=IMState('FixMode')<CR>

" 大文字入力切り替え
imap j<Space>j <Plug>CapsLockToggle


""""""""""""""""""""""""""""""
"IMEの状態とカーソル位置保存のため<C-r>を使用してコマンドを実行。
""""""""""""""""""""""""""""""
function! MyExecExCommand(cmd, ...)
  let saved_ve = &virtualedit
  let index = 1
  while index <= a:0
    if a:{index} == 'onemore'
      silent setlocal virtualedit+=onemore
    endif
    let index = index + 1
  endwhile

  silent exec a:cmd
  if a:0 > 0
    silent exec 'setlocal virtualedit='.saved_ve
  endif
  return ''
endfunction


" Arpeggio cnoremap and inoremap
function! s:cinoremap(lhs, rhs) abort
    call arpeggio#map('i', '', 0, a:lhs, a:rhs)
    call arpeggio#map('c', '', 0, a:lhs, a:rhs)
endfunction

call arpeggio#load()

" 入力系
call s:cinoremap("or", "<Bar>")
call s:cinoremap("ls", "[]<Left>")
call s:cinoremap("ka", "()<Left>")
call s:cinoremap("ye", "\\")
call s:cinoremap("ia", "=>")
call s:cinoremap("ht", "^")
" call s:cinoremap("dp", "()")
" call s:cinoremap("hw", "\"\"")
call s:cinoremap("an", "&")
call s:cinoremap("sh", "#")
call s:cinoremap("ti", "~")
call s:cinoremap("do", "$")
call s:cinoremap("bi", "!")
call s:cinoremap("b,", "`")
call s:cinoremap("gi", "?")
call s:cinoremap("w,", "\"")
call s:cinoremap("q,", "'")
call s:cinoremap("ps", "+")
call s:cinoremap("ya", "->")
call s:cinoremap("ri", "%")
call s:cinoremap("ma", "@")
call s:cinoremap("co", ":")
call s:cinoremap("cl", "*")
call s:cinoremap("ha", "-")
call s:cinoremap("ek", "=")
call s:cinoremap("us", "_")
call s:cinoremap("bk", "``<Left>")
call s:cinoremap("wk", "\"\"<Left>")
call s:cinoremap("lt", "<><Left>")
call s:cinoremap("di", "{}<Left>")
call s:cinoremap("qo", "''<Left>")

" 入力系以外
call s:cinoremap(";a", "<Home>")
call s:cinoremap(";e", "<End>")
call s:cinoremap(";d", "<Del>")
call s:cinoremap(";b", "<BS>")
call s:cinoremap(";c", "<End><C-u>")
call s:cinoremap(";z", "<C-a>")
call s:cinoremap(";h", "<C-r>\"")
call s:cinoremap("gl", "<Right>")
call s:cinoremap("gh", "<Left>")
call s:cinoremap("gj", "<Down>")
call s:cinoremap("gk", "<Up>")
