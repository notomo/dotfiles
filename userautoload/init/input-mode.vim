" 移動
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <M-b> <C-Left>
inoremap <M-f> <C-Right>
inoremap <C-a> <C-r>=MyExecExCommand('normal ^')<CR>
inoremap <C-e> <END>

" 編集
inoremap <C-o> <C-g>u<C-r>=MyExecExCommand('normal o')<CR>
inoremap <M-j> <C-g>u<C-r>=MyExecExCommand('normal! J')<CR>
inoremap <M-d> <C-g>u<C-r>=MyExecExCommand('normal! D','onemore')<CR>
inoremap <C-b> <BS>
inoremap <C-d> <Del>
inoremap <C-v> <C-r>"

" undo redo
inoremap <M-u> <C-g>u<C-r>=MyExecExCommand('undo', 'onemore')<CR>
inoremap <M-r> <C-r>=MyExecExCommand('redo', 'onemore')<CR>

" インデント
inoremap <TAB> <C-t>
inoremap <S-TAB> <C-d>

" 電卓
inoremap <M-c> <C-r>=

" 日本語入力固定切り替え
inoremap <F10> <C-^><C-r>=IMState('FixMode')<CR>

" 大文字入力切り替え
imap j<Space>j <Plug>CapsLockToggle

inoremap j<Space><Space> <ESC><Right>gUbea


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


" " Arpeggio cnoremap and inoremap
function! s:arpeggio_cinoremap(lhs, rhs) abort
    call arpeggio#map('i', '', 0, a:lhs, a:rhs)
    call arpeggio#map('c', '', 0, a:lhs, a:rhs)
endfunction

call arpeggio#load()
call s:arpeggio_cinoremap("dsa", "<Home>")
call s:arpeggio_cinoremap("kl;", "<End>")


inoremap j<Space><CR> <C-r>=
inoremap j<Space>z <C-a>

function! s:cinoremap(lhs_prefix_key, lhs_suffix_key, rhs) abort
    let lhs_rhs = a:lhs_prefix_key . a:lhs_suffix_key . " " . a:rhs
    execute "cnoremap " . lhs_rhs
    execute "inoremap " . lhs_rhs
endfunction
let s:MAIN_INPUT_PREFIX_KEY = "j<Space>"
let s:SUB_INPUT_PREFIX_KEY = "jk"

call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "a" ,"-")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "e" ,"=")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "s" ,"_")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "w" ,"\"\"<Left>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "b" ,"``<Left>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "l" ,"[]<Left>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "t" ,"<><Left>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "p" ,"()<Left>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "d" ,"{}<Left>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "q" ,"''<Left>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "h" ,"<C-r>\"")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "k" ,"<End><C-u>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "u" ,"<C-u>")
call s:cinoremap(s:MAIN_INPUT_PREFIX_KEY, "c" ,"<End><C-u><C-u>")

call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "a", "&")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "h", "^")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "p", "+")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "s", "#")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "r", "%")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "m", "@")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "t", "~")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "d", "$")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "e", "!")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "b", "`")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "c", ":")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "x", "*")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "q", "?")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, ";", "\"")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, ",", "'")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "y", "\\")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "w", "\"\"")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "o", "<Bar>")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "g", "=>")
call s:cinoremap(s:SUB_INPUT_PREFIX_KEY, "f", "->")

