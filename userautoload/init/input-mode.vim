
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

inoremap j<Space><CR> <C-r>=

inoremap j<Space>a -
inoremap j<Space>e =
inoremap j<Space>s _
inoremap j<Space>w ""<Left>
inoremap j<Space>b ``<Left>
inoremap j<Space>l []<Left>
inoremap j<Space>t <><Left>
inoremap j<Space>p ()<Left>
inoremap j<Space>d {}<Left>
inoremap j<Space>q ''<Left>
inoremap j<Space>g <End>
inoremap j<Space>k <Del>
inoremap j<Space>j <BS>
" inoremap j<Space>h <Home>
inoremap j<Space>f <Right>
inoremap j<Space>v <ESC>Jxi
inoremap j<Space>z <C-a>
inoremap j<Space>c <ESC>cc
inoremap j<Space>x <ESC><Right>C
inoremap j<Space>o <CR>
inoremap j<Space>r <C-k>
inoremap j<Space>/ <ESC>"/pa
inoremap j<Space><Space> <ESC><Right>gUbea
inoremap j<Space>h <C-r>"



inoremap jka &
inoremap jkh ^
inoremap jkp +
inoremap jks #
inoremap jkr %
inoremap jkm @
inoremap jkt ~
inoremap jko <Bar>
inoremap jkd $
inoremap jke !
inoremap jkb `
inoremap jkc :
inoremap jkx *
inoremap jkq ?
inoremap jk; "
inoremap jk, '
inoremap jky \
inoremap jkw "
inoremap jkg =>
inoremap jkf ->


cnoremap j<Space>a -
cnoremap j<Space>e =
cnoremap j<Space>s _
cnoremap j<Space>w ""<Left>
cnoremap j<Space>b ``<Left>
cnoremap j<Space>l []<Left>
cnoremap j<Space>t <><Left>
cnoremap j<Space>p ()<Left>
cnoremap j<Space>d {}<Left>
cnoremap j<Space>q ''<Left>
cnoremap j<Space>g <End>
cnoremap j<Space>k <Del>
cnoremap j<Space>j <BS>
" cnoremap j<Space>h <Home>
cnoremap j<Space>h <C-r>"
cnoremap j<Space>f <Right>
cnoremap j<Space>o <CR>

cnoremap jka &
cnoremap jkh ^
cnoremap jkp +
cnoremap jks #
cnoremap jkr %
cnoremap jkm @
cnoremap jkt ~
cnoremap jko <Bar>
cnoremap jkd $
cnoremap jke !
cnoremap jkb `
cnoremap jkc :
cnoremap jkx *
cnoremap jkq ?
cnoremap jk; "
cnoremap jk, '
cnoremap jky \
cnoremap jkw "
cnoremap jkg =>
cnoremap jkf ->


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

