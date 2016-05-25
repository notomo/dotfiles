
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
" inoremap <C-r> <Nop>

inoremap j<Space>a ->
inoremap j<Space>i =>
inoremap j<Space>b !
inoremap j<Space>m -
inoremap j<Space>e =
inoremap j<Space>u _
inoremap j<Space>T ~
inoremap j<Space>. +
inoremap j<Space>y \
inoremap j<Space>n #
inoremap j<Space>H ^
inoremap j<Space>d $
inoremap j<Space>c :
inoremap j<Space>x *
inoremap j<Space>r %
inoremap j<Space>O <Bar>
inoremap j<Space>w ""<Left>
inoremap j<Space>l []<Left>
inoremap j<Space>t <><Left>
inoremap j<Space>A &
inoremap j<Space>p ()<Left>
inoremap j<Space>g {}<Left>
inoremap j<Space>q ''<Left>
inoremap j<Space>o <End>
inoremap j<Space>k <Del>
inoremap j<Space>j <BS>
inoremap j<Space>h <Home>
inoremap j<Space>, '
inoremap j<Space>; "
inoremap j<Space>B `
inoremap j<Space>/ ?
inoremap j<Space>f <Right>
inoremap j<Space>M @
inoremap j<Space>v 5
inoremap j<Space>z 6
inoremap j<Space>s 7
inoremap j<Space>E 8
inoremap j<Space>N 9
inoremap j<Space><Space> <Tab>

cnoremap j<Space>a ->
cnoremap j<Space>i =>
cnoremap j<Space>b !
cnoremap j<Space>m -
cnoremap j<Space>e =
cnoremap j<Space>u _
cnoremap j<Space>T ~
cnoremap j<Space>. +
cnoremap j<Space>y \
cnoremap j<Space>n #
cnoremap j<Space>H ^
cnoremap j<Space>d $
cnoremap j<Space>c :
cnoremap j<Space>x *
cnoremap j<Space>r %
cnoremap j<Space>O <Bar>
cnoremap j<Space>w ""<Left>
cnoremap j<Space>l []<Left>
cnoremap j<Space>t <><Left>
cnoremap j<Space>A &
cnoremap j<Space>p ()<Left>
cnoremap j<Space>g {}<Left>
cnoremap j<Space>q ''<Left>
cnoremap j<Space>o <End>
cnoremap j<Space>k <Del>
cnoremap j<Space>j <BS>
cnoremap j<Space>h <Home>
cnoremap j<Space>, '
cnoremap j<Space>; "
cnoremap j<Space>B `
cnoremap j<Space>/ ?
cnoremap j<Space>f <Right>
cnoremap j<Space>M @
cnoremap j<Space>v 5
cnoremap j<Space>z 6
cnoremap j<Space>s 7
cnoremap j<Space>E 8
cnoremap j<Space>N 9
cnoremap j<Space><Space> j



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

