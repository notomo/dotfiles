
" 入力モードでカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

inoremap <C-x> <C-a>
inoremap <C-z> <C-@>
inoremap <C-a> <C-r>=MyExecExCommand('normal ^')<CR>
inoremap <C-e> <END>
inoremap <C-b> <BS>
inoremap <C-d> <Del>
inoremap <TAB> <C-t>
inoremap <S-TAB> <C-d>
inoremap <C-v> <C-r>"

" 「日本語入力固定モード」切替キー
inoremap <silent> <F10> <C-^><C-r>=IMState('FixMode')<CR>
"undo
inoremap <silent> <M-u> <C-g>u<C-r>=MyExecExCommand('undo', 'onemore')<CR>
"カーソル行削除
"inoremap <silent> <C-d> <C-g>u<C-r>=MyExecExCommand('normal! dd', 'onemore')<CR>
"カーソル以降削除
inoremap <silent> <M-d> <C-g>u<C-r>=MyExecExCommand('normal! D','onemore')<CR>
"リドゥ
inoremap <silent> <M-r> <C-r>=MyExecExCommand('redo', 'onemore')<CR>
"行連結
inoremap <silent> <M-j> <C-g>u<C-r>=MyExecExCommand('normal! J')<CR>
"下の行に改行
inoremap <silent> <C-o> <C-g>u<C-r>=MyExecExCommand('normal o')<CR>

inoremap <silent> <M-b> <C-Left>
inoremap <silent> <M-f> <C-Right>
inoremap <C-r> <Nop>
inoremap <C-s> _

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

