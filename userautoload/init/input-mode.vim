
" ���̓��[�h�ŃJ�[�\���ړ�
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

" �u���{����͌Œ胂�[�h�v�ؑփL�[
inoremap <silent> <F10> <C-^><C-r>=IMState('FixMode')<CR>
"undo
inoremap <silent> <M-u> <C-g>u<C-r>=MyExecExCommand('undo', 'onemore')<CR>
"�J�[�\���s�폜
"inoremap <silent> <C-d> <C-g>u<C-r>=MyExecExCommand('normal! dd', 'onemore')<CR>
"�J�[�\���ȍ~�폜
inoremap <silent> <M-d> <C-g>u<C-r>=MyExecExCommand('normal! D','onemore')<CR>
"���h�D
inoremap <silent> <M-r> <C-r>=MyExecExCommand('redo', 'onemore')<CR>
"�s�A��
inoremap <silent> <M-j> <C-g>u<C-r>=MyExecExCommand('normal! J')<CR>
"���̍s�ɉ��s
inoremap <silent> <C-o> <C-g>u<C-r>=MyExecExCommand('normal o')<CR>

inoremap <silent> <M-b> <C-Left>
inoremap <silent> <M-f> <C-Right>
inoremap <C-r> <Nop>
inoremap <C-s> _
inoremap <C-d> $
snoremap <C-d> $
inoremap <M-a> ->
inoremap <M-d> =>
inoremap <M-e> =
inoremap <M-i> $this
inoremap <M-p> []<Left>
inoremap <M-s> ()<Left>
inoremap <M-q> ''<Left>

inoremap [input] <Nop>
imap j<Space> [input]

inoremap [input]a ->
inoremap [input]i =>
inoremap [input]b !
inoremap [input]m -
inoremap [input]e =
inoremap [input]u _
inoremap [input]T ~
inoremap [input]l +
inoremap [input]y \
inoremap [input]n #
inoremap [input]h ^
inoremap [input]d $
inoremap [input]c :
inoremap [input]k *
inoremap [input]r %
inoremap [input]o <Bar>
inoremap [input]w ""<Left>
inoremap [input]p []<Left>
inoremap [input]P &
inoremap [input]s ()<Left>
inoremap [input]S {}<Left>
inoremap [input]q ''<Left>
inoremap [input]g <End>
inoremap [input]t <Home>
inoremap [input]x <Del>
inoremap [input]; <BS>
inoremap [input]j '
inoremap [input]f "
inoremap [input];a 1
inoremap [input];s 2
inoremap [input];d 3
inoremap [input];f 4
inoremap [input];g 5
inoremap [input];h 6
inoremap [input];j 7
inoremap [input];k 8
inoremap [input];l 9
inoremap [input];; 10
inoremap [input]<Space> j<Space>


""""""""""""""""""""""""""""""
"IME�̏�ԂƃJ�[�\���ʒu�ۑ��̂���<C-r>���g�p���ăR�}���h�����s�B
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

